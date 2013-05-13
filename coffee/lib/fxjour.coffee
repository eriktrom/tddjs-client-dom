do ->

  iframe = ->
    document.getElementById(fixtures.containerId)

  iframeWindow = ->
    iframe().contentWindow || iframe().contentDocument

  fixtureDoc = ->
    iframe().contentDocument

  fixtureById = (id) ->
    fixtureDoc().getElementById(id)

  fixture = (elementId) ->
    iframeWindow().document.body.firstChild

  tddjs.namespace("dom").fxjour = {fixture, fixtureDoc, fixtureById}