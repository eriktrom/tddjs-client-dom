# TODO: Write some tests for addEventListener feature detection
# TODO: it doesn't seem like I need this after all? It all seems to be defined
# in tdd.coffee?
addEventHandler = (element, type, listener) ->
  if tddjs.isHostMethod(element, "addEventListener")
    element.addEventListener(type, listener, false)
  else if tddjs.isHostMethod(element, "attachEvent") && listener.call
    element.attachEvent "on#{type}", -> listener.call(element, window.event)
  else
    # possibly fall back to DOM0 event properties or abort
