do ->
  expect = chai.expect
  fxjour = tddjs.namespace("dom").fxjour

  describe "fxjour", ->
    it "should embed HTML", ->
      fixtures.set("<div></div>")
      expect(fxjour.fixture().tagName.toLowerCase()).to.eq "div"

    it "should append HTML to document", ->
      fixtures.set('<div id="myDiv"></div>')
      expect(fxjour.fixtureById("myDiv").tagName.toLowerCase()).to.eq "div"