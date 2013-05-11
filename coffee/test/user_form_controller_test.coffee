do ->
  expect = chai.expect

  userController = tddjs.chat.userFormController
  domDbl = tddjs.namespace("dom")

  iframe = ->
    document.getElementById(fixtures.containerId)

  iframeWindow = ->
    iframe().contentWindow || iframe().contentDocument

  fixtureById = (id) ->
    iframe().contentDocument.getElementById(id)

  fixture = (elementId) ->
    iframeWindow().document.body.firstChild

  describe "userFormController", ->
    beforeEach ->
      @controller = Object.create(userController)
      @elementDbl = {}
      domDbl.addEventHandler = stubFn()

    afterEach ->
      fixtures.cleanUp()

    it "should be an object", ->
      expect(userController).to.be.an "object"

    it "should have setView method", ->
      expect(userController.setView).to.be.a "function"

    describe "#setView", ->

      it "should add js-chat class", ->
        @controller.setView(@elementDbl)
        expect(@elementDbl.className).to.eq "js-chat"

      # no need to add an actual DOM event listener while testing
      # simply stub addEventHandler in the tests, pg 395
      it "should handle an element's submit event", ->
        @controller.setView(@elementDbl)

        expect(domDbl.addEventHandler.called).to.eq true
        expect(domDbl.addEventHandler.args[0]).to.eq @elementDbl
        expect(domDbl.addEventHandler.args[1]).to.eq "submit"
        expect(domDbl.addEventHandler.args[2]).to.be.a "function"

      # verify that the event handler is bound to the controller
      # object. Use stubFn to record the value of `this` at call time
      #
      # assert that the event handler is the controller's handleSubmit method,
      # readily bound to the controller object
      it "should handle 'submit' event from elementDbl with bound handleSubmit", ->
        handleSubmitStub = @controller.handleSubmit = stubFn()

        @controller.setView(@elementDbl)
        domDbl.addEventHandler.args[2]()

        expect(handleSubmitStub.called).to.eq true
        expect(handleSubmitStub.thisValue).to.eq @controller

    describe "#handleSubmit", ->
      # When a user submits the form, the handler should grab the value from the
      # form's first input element who's type is text, assign it to the model's
      # currentUser property and then remove the "js-chat" class name, signifying
      # end of life for the user component.
      # Last but not least, the handler needs to abort the events default action

      it "should prevent the event's default browser action", ->
        eventDbl = {preventDefault: stubFn()}
        @controller.handleSubmit(eventDbl)
        expect(eventDbl.preventDefault.called).to.eq true

    describe "embedding HTML in a mocha test", ->
      it "should embed HTML", ->
        fixtures.set("<div></div>")
        expect(fixture().tagName.toLowerCase()).to.eq "div"

      it "should append HTML to document", ->
        fixtures.set('<div id="myDiv"></div>')
        expect(fixtureById("myDiv").tagName.toLowerCase()).to.eq "div"
