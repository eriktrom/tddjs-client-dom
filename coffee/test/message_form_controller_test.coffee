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