do ->

  dom = tddjs.namespace("dom")

  setView = (element) ->
    element.className = "js-chat"
    dom.addEventHandler element, "submit", ->

  tddjs.namespace("chat").userFormController = {setView}