do ->
  expect = chai.expect
  messageController = tddjs.chat.messageFormController
  formController = tddjs.chat.formController

  describe "messageFormController", ->

    it "should inherit #setView from formController", ->
      expect(messageController.setView).to.not.be.undefined # tricky, tricky, if both are undefined in the next assertion, they will in fact be eq
      expect(messageController.setView).to.eq formController.setView

    it "should inherit #setModel from formController", ->
      expect(messageController.setModel).to.not.be.undefined
      expect(messageController.setModel).to.eq formController.setModel

    it "should have handle submit method", ->
      expect(messageController.handleSubmit).to.be.a "function"

    describe "#handleSubmit", ->

      beforeEach ->
        @controller = Object.create(messageController)

      it "should publish a 'message' event on the model", ->
        modelDbl = {notify: stubFn()}
        @controller.setModel(modelDbl)

        @controller.handleSubmit()

        expect(modelDbl.notify.called).to.eq true
        expect(modelDbl.notify.args[0]).to.eq "message"
        expect(modelDbl.notify.args[1]).to.be.a "object"
# Publishing Messages
# When the user submits the form, the controller should publish a message to the
# model object
#
# To test this we can stub the model's notify method, call handleSubmit, and
# expect the stub to be called

# NOTE: Mocha passes a test when there is no expectation. What the fuck.