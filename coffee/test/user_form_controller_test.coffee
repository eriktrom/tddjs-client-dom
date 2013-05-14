do ->
  expect = chai.expect

  userController = tddjs.chat.userFormController
  formController = tddjs.chat.formController
  domDbl = tddjs.namespace("dom")
  fxjour = domDbl.fxjour

  describe "userFormController", ->

    it "should inherit #setView from formController", ->
      expect(userController.setView).to.eq formController.setView

    beforeEach ->
      @controller = Object.create(userController)
      # FIXME: this fixture is being set twice - once here and once in
      # formController test
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

        context "when username field is empty", ->
          beforeEach ->
            @elementDbl.getElementsByTagName("input")[0].value = ""
            setViewAndModel.call(@)
            @observerCbDbl = stubFn()
            @controller.observe("user", @observerCbDbl)

          it "should NOT notify observers", ->
            @controller.handleSubmit(@eventDbl)
            expect(@observerCbDbl.called).to.eq false

          it "should NOT remove the className", ->
            @controller.handleSubmit(@eventDbl)
            expect(@elementDbl.className).to.eq "js-chat"