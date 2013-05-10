do ->

  dom = tddjs.namespace("dom")

  setView = (element) ->
    element.className = "js-chat"
    dom.addEventHandler element, "submit", @handleSubmit.bind(@)

  handleSubmit = (event) ->
    event.preventDefault()

  tddjs.namespace("chat").userFormController = {
    setView
    handleSubmit
  }