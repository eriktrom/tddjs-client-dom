do ->

  setModel = (model) ->
    model.observe "message", @addMessage.bind(@)

  setView = (element) ->
    element.className = 'js-chat'

  addMessage = ->

  tddjs.namespace("chat").messageListController = {
    setModel
    addMessage
    setView
  }