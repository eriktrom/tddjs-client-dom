do ->
  assert = chai.assert
  expect = chai.expect

  userController = tddjs.chat.userFormController

  describe "User Form Controller", ->

    it "should be an object", ->
      assert.isObject userController

    it "should have setView method", ->
      assert.isFunction userController.setView

    describe "Set View", ->

      it "should add js-chat class", ->
        controller = Object.create(userController)
        elementDbl = {}

        controller.setView(elementDbl)

        expect(elementDbl.className).to.eq "js-chat"