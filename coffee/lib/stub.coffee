stubFn = (returnValue) ->
  fn = ->
    fn.called = true
    fn.args = Array::slice.call(arguments)
    fn.thisValue = @
    returnValue
  fn.called = false
  fn