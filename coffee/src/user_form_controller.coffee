do ->
  return if typeof tddjs is "undefined" || typeof document is "undefined"
  util = tddjs.util # can use this b/c observable.coffee defines/loads first
  chat = tddjs.namespace("chat")
  return if !document.getElementsByTagName

  handleSubmit = (event) ->
    event.preventDefault()
    if @view
      userName = @view.getElementsByTagName("input")[0].value
      return unless userName
      @view.className = ""
      @model.currentUser = userName
      @notify("user", userName)

  setModel = (@model) ->

  chat.userFormController = Object.create(chat.formController)
  chat.userFormController.setModel = setModel
  chat.userFormController.handleSubmit = handleSubmit