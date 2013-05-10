stubFn = (returnValue) ->
  fn = ->
    fn.called = true
    fn.args = arguments
    fn.thisValue = @
    returnValue
  fn.called = false
  fn