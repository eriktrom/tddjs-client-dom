do ->

  setView = (element) ->
    element.className = "js-chat"

  tddjs.namespace("chat").userFormController = {setView}