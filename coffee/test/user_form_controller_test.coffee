do ->
  expect = chai.expect

  userController = tddjs.chat.userFormController
  domDbl = tddjs.namespace("dom")

  describe "userFormController", ->
    beforeEach ->
      @controller = Object.create(userController)
      @elementDbl = {}
      domDbl.addEventHandler = stubFn()

    it "should be an object", ->
      expect(userController).to.be.an "object"

    it "should have setView method", ->
      expect(userController.setView).to.be.a "function"

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
