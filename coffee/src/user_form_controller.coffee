do ->

  dom = tddjs.namespace("dom")

  setView = (element) ->
    element.className = "js-chat"
    dom.addEventHandler element, "submit", @handleSubmit.bind(@)
    @view = element

  handleSubmit = (event) ->
    event.preventDefault()
    if @view
      input = @view.getElementsByTagName("input")[0]
      @model.currentUser = input.value

  setModel = (@model) ->

  tddjs.namespace("chat").userFormController = {
    setView
    handleSubmit
    setModel
  }