do ->

  handleSubmit = (event) ->
    @model.notify "message",
      user: @model.currentUser
      message: @view.getElementsByTagName("input")[0].value


  chat = tddjs.namespace("chat")
  chat.messageFormController = Object.create(chat.formController)
  chat.messageFormController.handleSubmit = handleSubmit