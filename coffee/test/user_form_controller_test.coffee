do ->
  assert = chai.assert
  expect = chai.expect

  userController = tddjs.chat.userFormController

  describe "User Form Controller", ->
    it "should be an object", ->
      assert.isObject userController