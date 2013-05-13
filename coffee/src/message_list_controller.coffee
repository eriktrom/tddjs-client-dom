do ->

  setModel = (model) ->
    model.observe "message", @addMessage.bind(@)

  addMessage = ->

  tddjs.namespace("chat").messageListController = {
    setModel
    addMessage
  }