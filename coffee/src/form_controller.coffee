do ->
  return if typeof tddjs is "undefined"
  dom = tddjs.dom
  util = tddjs.util
  chat = tddjs.namespace("chat")
  return if !dom || !dom.addEventHandler || !util || !util.observable ||
            !Object.create || !Function::bind

  setView = (element) ->
    element.className = "js-chat"
    dom.addEventHandler element, "submit", @handleSubmit.bind(@)
    @view = element

  setModel = (@model) ->


  chat.formController = tddjs.extend({}, util.observable)
  chat.formController.setView = setView
  chat.formController.setModel = setModel