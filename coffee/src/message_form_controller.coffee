do ->

  return if typeof tddjs is "undefined" || typeof document is "undefined"
  chat = tddjs.namespace("chat")
  return if !chat.formController || !document.getElementsByTagName

  handleSubmit = (event) ->
    event.preventDefault()
    msgInput = @view.getElementsByTagName("input")[0]
    @model.notify "message",
      user: @model.currentUser
      message: msgInput.value
    msgInput.value = ""




  chat.messageFormController = Object.create(chat.formController)
  chat.messageFormController.handleSubmit = handleSubmit