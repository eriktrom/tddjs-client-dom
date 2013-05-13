do ->

  dom = tddjs.namespace("dom")
  util = tddjs.util # can use this b/c observable.coffee defines/loads first
  chat = tddjs.namespace("chat")

  setView = (element) ->
    element.className = "js-chat"
    dom.addEventHandler element, "submit", @handleSubmit.bind(@)
    @view = element

  handleSubmit = (event) ->
    event.preventDefault()
    if @view
      input = @view.getElementsByTagName("input")[0]
      @model.currentUser = input.value
      @notify("user", input.value)

  setModel = (@model) ->

  chat.userFormController = tddjs.extend({}, util.observable)
  chat.userFormController.setView = setView
  chat.userFormController.setModel = setModel
  chat.userFormController.handleSubmit = handleSubmit