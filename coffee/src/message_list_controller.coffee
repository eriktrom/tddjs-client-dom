do ->

  setModel = (model) ->
    model.observe "message", ->

  tddjs.namespace("chat").messageListController = {
    setModel
  }