do ->

  handleSubmit = (event) ->
    @model.notify("message", {})



  chat = tddjs.namespace("chat")
  chat.messageFormController = Object.create(chat.formController)
  chat.messageFormController.handleSubmit = handleSubmit