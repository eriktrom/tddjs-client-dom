do ->
  expect = chai.expect
  messageController = tddjs.chat.messageFormController

  describe "messageFormController", ->
    it "should be an object", ->
      expect(messageController).to.be.an "object"