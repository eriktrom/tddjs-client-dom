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

      it "should publish a 'message' event on the model", ->
        @controller.handleSubmit()

        expect(@modelDbl.notify.called).to.eq true
        expect(@modelDbl.notify.args[0]).to.eq "message"
        expect(@modelDbl.notify.args[1]).to.be.a "object"

      it "publishes object that includes currentUser as its user property", ->
        @modelDbl.currentUser = "erik"
        @controller.handleSubmit()
        expect(@modelDbl.notify.args[1].user).to.eq "erik"

      it "should publish message from the form", ->
        @elementDbl.getElementsByTagName("input")[0].value = "hello caroline"
        @controller.handleSubmit()
        expect(@modelDbl.notify.args[1].message).to.eq "hello caroline"


# Publishing Messages
# When the user submits the form, the controller should publish a message to the
# model object
#
# To test this we can stub the model's notify method, call handleSubmit, and
# expect the stub to be called

# NOTE: Mocha passes a test when there is no expectation. What the fuck.