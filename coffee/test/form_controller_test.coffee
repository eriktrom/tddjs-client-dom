do ->
  expect = chai.expect

  formController = tddjs.namespace("chat").formController
  domDbl = tddjs.namespace("dom")
  fxjour = domDbl.fxjour

  describe "formController", ->

    it "should be an object", ->
      expect(formController).to.be.an "object"

    it "should have setView method", ->
      expect(formController.setView).to.be.a "function"

    it "should play the role of an observable", ->
      expect(formController.observe).to.be.a "function"
      expect(formController.hasObserver).to.be.a "function"
      expect(formController.notify).to.be.a "function"
      # this is an interface, shared behavior, consider something like
      # it_should_behave_like

    beforeEach ->
      @controller = Object.create(formController)
      fixtures.set '''
        <form>
          <fieldset>
            <label for="username">Username</label>
            <input type="text" name="username" id="username">
            <input type="submit" value="Enter">
          </fieldset>
        </form>
      '''
      @elementDbl = fxjour.fixture()
      domDbl.addEventHandler = stubFn()
      @eventDbl = {preventDefault: stubFn()}
      @controller.handleSubmit = stubFn()

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
        # NOTE: the naming conveention of handleSubmitStub - I use the word stub
        # here instead of double b/c we're 'stubbing' a method on an object
        # not creating an object double
      it "should handle 'submit' event from elementDbl with bound handleSubmit", ->
        handleSubmitStub = @controller.handleSubmit = stubFn()

        @controller.setView(@elementDbl)
        domDbl.addEventHandler.args[2]()

        expect(handleSubmitStub.called).to.eq true
        expect(handleSubmitStub.thisValue).to.eq @controller