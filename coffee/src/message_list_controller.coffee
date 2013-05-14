do ->

  setModel = (model) ->
    model.observe "message", @addMessage.bind(@)

  setView = (element) ->
    element.className = 'js-chat'
    @view = element

  addMessage = (message) ->
    if @prevUser isnt message.user
      daUser = document.createElement("dt")
      daUser.innerHTML = "@#{message.user}"
      @view.appendChild(daUser)
      @prevUser = message.user

    daMessage = document.createElement("dd")
    daMessage.innerHTML = message.message.replace(/</g, "&lt;")
    @view.appendChild(daMessage)

  tddjs.namespace("chat").messageListController = {
    setModel
    addMessage
    setView
  }