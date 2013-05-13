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

  describe "messageListController", ->

    it "should be an object", ->
      expect(listController).to.be.an "object"

    it "should have setModel method", ->
      expect(listController.setModel).to.be.a "function"

    beforeEach ->
      @controller = Object.create(listController)
      @modelDbl = {observe: stubFn()}

    describe "#setModel", ->

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
        fixtures.set '''<dl></dl>'''
        @elementDbl = fxjour.fixture()

      it "should set class to 'js-chat'", ->
        @controller.setView(@elementDbl)
        expect(@elementDbl.className).to.eq "js-chat"