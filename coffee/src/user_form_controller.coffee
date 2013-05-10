do ->

  dom = tddjs.namespace("dom")

  setView = (element) ->
    element.className = "js-chat"
    dom.addEventHandler element, "submit", @handleSubmit.bind(@)
    # SAME AS
    # dom.addEventHandler element, "submit", => @handleSubmit()

  handleSubmit = ->

  tddjs.namespace("chat").userFormController = {
    setView
    handleSubmit
  }