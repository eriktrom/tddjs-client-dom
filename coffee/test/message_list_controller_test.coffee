###
The Message List:
- will consist of a definition list, where messages are represented by a dt
  element containing the user and a dd element containing the message
- The controller will observe the model's "message" channel to receive messages
  and will build DOM elements and inject them into the view
- As with the user form controller, it will add the "js-chat" class to the view
  when it is set
###

do ->
  expect = chai.expect
  listController = tddjs.chat.messageListController

  describe "messageListController", ->

    it "should be an object", ->
      expect(listController).to.be.an "object"

    it "should have setModel method", ->
      expect(listController.setModel).to.be.a "function"

    describe "#setModel", ->

      beforeEach ->
        @controller = Object.create(listController)
        @modelDbl = {observe: stubFn()}

      it "should observe model's message channel", ->
        @controller.setModel(@modelDbl)

        expect(@modelDbl.observe.called).to.eq true
        expect(@modelDbl.observe.args[0]).to.eq "message"
        expect(@modelDbl.observe.args[1]).to.be.a "function"

      it "should observe with bound addMessage", ->
        addMessageStub = @controller.addMessage = stubFn()

        @controller.setModel(@modelDbl)
        @modelDbl.observe.args[1]()

        expect(addMessageStub.called).to.eq true
        expect(addMessageStub.thisValue).to.eq @controller