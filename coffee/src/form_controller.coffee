do ->
  return if typeof tddjs is "undefined"
  dom = tddjs.dom
  return if !dom || !dom.addEventHandler || !Function::bind

  setView = (element) ->
    element.className = "js-chat"
    dom.addEventHandler element, "submit", @handleSubmit.bind(@)
    @view = element

  tddjs.namespace("chat").formController = {
    setView
  }
