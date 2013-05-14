do ->
  expect = chai.expect
  messageController = tddjs.chat.messageFormController
  formController = tddjs.chat.formController

  describe "messageFormController", ->

    it "should inherit #setView from formController", ->
      expect(messageController.setView).to.eq formController.setView