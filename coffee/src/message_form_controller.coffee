do ->

  handleSubmit = (event) ->
    @model.notify("message", {user: @model.currentUser})



  chat = tddjs.namespace("chat")
  chat.messageFormController = Object.create(chat.formController)
  chat.messageFormController.handleSubmit = handleSubmit