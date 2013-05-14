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


# TODO: to fully refactor, we should change the tests as well. The tests we
# originally wrote for userFormController#setView should be updated to test
# this formController directly.
# To make sure the userFormController still works, we can replace the original
# test case with a single test that verifies that userFormController inherits
# the setView method from formController
# Note that the original tests better document userFormController but duplicating
# them comes with a maintenance cost, tradeoffs is the name of the game. Duplication
# is almost always the worst