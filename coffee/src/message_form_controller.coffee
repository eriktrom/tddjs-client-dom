do ->

  return if typeof tddjs is "undefined" || typeof document is "undefined"
  chat = tddjs.namespace("chat")
  return if !chat.formController || !document.getElementsByTagName

  handleSubmit = (event) ->
    event.preventDefault()
    @model.notify "message",
      user: @model.currentUser
      message: @view.getElementsByTagName("input")[0].value
    @view.getElementsByTagName("input")[0].value = ""




  chat.messageFormController = Object.create(chat.formController)
  chat.messageFormController.handleSubmit = handleSubmit