###
The Message List:
- will consist of a definition list, where messages are represented by a dt
  element containing the user and a dd element containing the message
- The controller will observe the model's "message" channel to receive messages
  and will build DOM elements and inject them into the view
- As with the user form controller, it will add the "js-chat" class to the view
  when it is set
###

do ->
  expect = chai.expect
  listController = tddjs.chat.messageListController
  domDbl = tddjs.namespace("dom")
  fxjour = domDbl.fxjour

  controllerSetup = ->
    @controller = Object.create(listController)
    @modelDbl = {observe: stubFn()}

  viewRelatedSetup = ->
    fixtures.set '''<dl></dl>'''
    @elementDbl = fxjour.fixture()

  describe "messageListController", ->

    it "should be an object", ->
      expect(listController).to.be.an "object"

    it "should have setModel method", ->
      expect(listController.setModel).to.be.a "function"

    describe "#setModel", ->

      beforeEach ->
        controllerSetup.call(@)

      # NOTE: when first running the following 2 tests, the 2nd test made the
        # first test fail and it wasn't obvious(until the book told me). The problem
        # was that the error message given by karma pointed to a line inside of
        # a message_list_controller_test.coffee-compiled.js -- which I don't have
        # access to with this setup.. Or I might, I just don't know where. This
        # would have been a place that using in browser tests may hve certainly helped
        # alot
      it "should observe model's message channel", ->
        @controller.setModel(@modelDbl)

        expect(@modelDbl.observe.called).to.eq true
        expect(@modelDbl.observe.args[0]).to.eq "message"
        expect(@modelDbl.observe.args[1]).to.be.a "function"

      it "should observe with bound addMessage", ->
        addMessageStub = @controller.addMessage = stubFn()

        @controller.setModel(@modelDbl)
        @modelDbl.observe.args[1]()

        expect(addMessageStub.called).to.eq true
        expect(addMessageStub.thisValue).to.eq @controller

    describe "#setView", ->

      beforeEach ->
        controllerSetup.call(@)
        viewRelatedSetup.call(@)

      it "should set class to 'js-chat'", ->
        @controller.setView(@elementDbl)
        expect(@elementDbl.className).to.eq "js-chat"

    describe "addMessage", ->

      beforeEach ->
        controllerSetup.call(@)
        viewRelatedSetup.call(@)
        @controller.setModel(@modelDbl)
        @controller.setView(@elementDbl)
        @dts = @elementDbl.getElementsByTagName("dt")
        @dds = @elementDbl.getElementsByTagName("dd")

      # add a message and then expect the definition list(<dl>) to have gained
      # a <dt> element. To pass the test, we need to build an element and append
      # it to the view
      it "should add dt element with @user", ->
        @controller.addMessage
          user: "erik"
          message: "my name is spelled with a k"

        expect(@dts.length).to.eq 1
        expect(@dts[0].innerHTML).to.eq "@erik"

      it "should add dd element with message", ->
        @controller.addMessage
          user: "bob"
          message: "Hello, I'm bob"

        expect(@dds.length).to.eq 1
        expect(@dds[0].innerHTML).to.eq "Hello, I'm bob"

      it "should escape HTML in messages", ->
        @controller.addMessage
          user: "Dr. Evil"
          message: "<script>window.alert('p4wned!');</script>"

        # in the book he had this:
          # expected = "&lt;script>window.alert('p4wned!');&lt;/script>"
          # Not sure what's going on here, notice the &gt; replacement of >
        expected = "&lt;script&gt;window.alert('p4wned!');&lt;/script&gt;"
        expect(@dds[0].innerHTML).to.eq expected

      it "should not repeat the name of the user in a dt when > 1 message received", ->
        @controller.addMessage {user: "erik", message: "hello world"}
        @controller.addMessage {user: "erik", message: ":)"}

        expect(@dts.length).to.eq 1
        expect(@dds.length).to.eq 2