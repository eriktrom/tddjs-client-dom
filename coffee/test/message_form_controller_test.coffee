do ->
  expect = chai.expect
  messageController = tddjs.chat.messageFormController
  formController = tddjs.chat.formController
  fxjour = tddjs.namespace("dom").fxjour

  describe "messageFormController", ->

    it "should inherit #setView from formController", ->
      expect(messageController.setView).to.exist # tricky, tricky, if both are undefined in the next assertion, they will in fact be eq
      expect(messageController.setView).to.eq formController.setView

    it "should inherit #setModel from formController", ->
      expect(messageController.setModel).to.not.be.undefined
      expect(messageController.setModel).to.eq formController.setModel

    it "should have handle submit method", ->
      expect(messageController.handleSubmit).to.be.a "function"

    describe "#handleSubmit", ->

      beforeEach ->
        @controller = Object.create(messageController)
        @modelDbl = {notify: stubFn()}
        @controller.setModel(@modelDbl)
        fixtures.set '''
          <form>
            <fieldset>
              <input type="text" name="message" id="message">
              <input type="submit" value="Send">
            </fieldset>
          </form>
        '''
        @elementDbl = fxjour.fixture()
        @controller.setView(@elementDbl)
        @eventDbl = {preventDefault: stubFn()}

      it "should publish a 'message' event on the model", ->
        @controller.handleSubmit(@eventDbl)

        expect(@modelDbl.notify.called).to.eq true
        expect(@modelDbl.notify.args[0]).to.eq "message"
        expect(@modelDbl.notify.args[1]).to.be.a "object"

      it "publishes object that includes currentUser as its user property", ->
        @modelDbl.currentUser = "erik"
        @controller.handleSubmit(@eventDbl)
        expect(@modelDbl.notify.args[1].user).to.eq "erik"

      it "should publish message from the form", ->
        @elementDbl.getElementsByTagName("input")[0].value = "hello caroline"
        @controller.handleSubmit(@eventDbl)
        expect(@modelDbl.notify.args[1].message).to.eq "hello caroline"

      it "should prevent default action of submitting to server", ->
        @eventDbl = {preventDefault: stubFn()}
        @controller.handleSubmit(@eventDbl)
        expect(@eventDbl.preventDefault.called).to.eq true

      it "should not send empty messages"

      it "all methods should handle errors (all methods!)"

      it "should emit an event (using observable) from the message once the form
          is posted. Observe it to display a loader gif and emit a corresponding
          event from the message list controller when the same message is displayed
          to removed the loading indicator"

# Publishing Messages
# When the user submits the form, the controller should publish a message to the
# model object
#
# To test this we can stub the model's notify method, call handleSubmit, and
# expect the stub to be called

# NOTE: Mocha passes a test when there is no expectation. What the fuck.

# TODO: To bootstrap the final working application pg 429, 430 + the other todo
# where I mentioned we needed to do the same after implementing the messageListController

# TODO: Once you bootstrap the app and get it working, you'll want to fix the
# scrolling issue, discussed on pg 431,432