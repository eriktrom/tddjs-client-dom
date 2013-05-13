do ->

  iframe = ->
    document.getElementById(fixtures.containerId)

  iframeWindow = ->
    iframe().contentWindow || iframe().contentDocument

  fixtureDoc = ->
    iframe().contentDocument

  fixtureById = (id) ->
    fixtureDoc().getElementById(id)

  fixture = (elementId) ->
    iframeWindow().document.body.firstChild

  tddjs.namespace("dom").fxjour = {fixture, fixtureDoc, fixtureById}

do ->
  expect = chai.expect
  fxjour = tddjs.namespace("dom").fxjour

  describe "fxjour", ->
    it "should embed HTML", ->
      fixtures.set("<div></div>")
      expect(fxjour.fixture().tagName.toLowerCase()).to.eq "div"

    it "should append HTML to document", ->
      fixtures.set('<div id="myDiv"></div>')
      expect(fxjour.fixtureById("myDiv").tagName.toLowerCase()).to.eq "div"

do ->
  expect = chai.expect

  userController = tddjs.chat.userFormController
  domDbl = tddjs.namespace("dom")
  fxjour = domDbl.fxjour

  describe "userFormController", ->
    beforeEach ->
      @controller = Object.create(userController)
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

    afterEach ->
      fixtures.cleanUp()

    it "should be an object", ->
      expect(userController).to.be.an "object"

    it "should have setView method", ->
      expect(userController.setView).to.be.a "function"

    it "should play the role of an observable", ->
      expect(userController.observe).to.be.a "function"
      expect(userController.hasObserver).to.be.a "function"
      expect(userController.notify).to.be.a "function"
      # this is an interface, shared behavior, consider something like
      # it_should_behave_like

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

    describe "#handleSubmit", ->
      # When a user submits the form, the handler should grab the value from the
        # form's first input element who's type is text, assign it to the model's
        # currentUser property and then remove the "js-chat" class name, signifying
        # end of life for the user component.
        # Last but not least, the handler needs to abort the events default action

      it "should prevent the event's default browser action", ->
        @controller.handleSubmit(@eventDbl)
        expect(@eventDbl.preventDefault.called).to.eq true

      context "when the view has been set", ->

        setViewAndModel = ->
          @controller.setView @elementDbl
          @modelDbl = {}
          @controller.setModel @modelDbl

        beforeEach ->
          @elementDbl.getElementsByTagName("input")[0].value = "erik"
          setViewAndModel.call(@)

        # read the username input field and set the value of it to model.currentUser
        it "should set model#currentUser with username input field value", ->
          @controller.handleSubmit(@eventDbl)
          expect(@modelDbl.currentUser).to.eq "erik"

        # once the user has been set, the controller should notify any observers
          # test this by:
          # - observing the event
          # - handling the event
          # - asserting that the observer was called
        it "should notify observers of username", ->
          observerCbDbl = stubFn()
          @controller.observe("user", observerCbDbl)

          @controller.handleSubmit(@eventDbl)

          expect(observerCbDbl.called).to.eq true
          expect(observerCbDbl.args[0]).to.eq "erik"

        it "should remove the className when successful", ->
          @controller.handleSubmit(@eventDbl)
          expect(@elementDbl.className).to.eq ""

        it "should NOT notify observers if username field is empty", ->
          @elementDbl.getElementsByTagName("input")[0].value = ""
          setViewAndModel.call(@)
          observerCbDbl = stubFn()
          @controller.observe("user", observerCbDbl)

          @controller.handleSubmit(@eventDbl)

          expect(observerCbDbl.called).to.eq false