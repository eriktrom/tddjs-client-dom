do ->
  expect = chai.expect

  describe "Observable", ->
    beforeEach ->
      @observable = Object.create(tddjs.util.observable)

    it "adds observers", ->
      observers = [(->), (->)]

      @observable.observe("event", observers[0])
      @observable.observe("event", observers[1])

      expect(@observable.hasObserver("event", observers[0])).to.eq true
      expect(@observable.hasObserver("event", observers[1])).to.eq true

  describe "#hasObserver", ->
    it "returns true when it has observer(s)", ->
      observerDbl = ->
      @observable.observe("event", observerDbl)
      expect(@observable.hasObserver("event", observerDbl)).to.eq true

    it "returns false when it has no observers", ->
      expect(@observable.hasObserver("event", ->)).to.eq false

  describe "#notify", ->
    it "calls all observers", ->
      observerDbl1 = stubFn()
      observerDbl2 = stubFn()
      @observable.observe("event", observerDbl1)
      @observable.observe("event", observerDbl2)

      @observable.notify("event")

      expect(observerDbl1.called).to.eq true
      expect(observerDbl2.called).to.eq true

    it "should pass through arguments", ->
      actual = null
      @observable.observe "event", -> actual = arguments

      @observable.notify("event", "String", 1, 32)

      expect(Array::slice.call(actual, 0)).to.deep.eq ["String", 1, 32]

    it "should notify all even when some fail", ->
      observerDbl1 = -> throw new Error("Oops")
      observerDbl2 = -> observerDbl2.called = true
      @observable.observe("event", observerDbl1)
      @observable.observe("event", observerDbl2)

      @observable.notify("event")

      expect(observerDbl2.called).to.eq true

    it "should call observers in the order they were added", ->
      calls = []
      observerDbl1 = -> calls.push(observerDbl1)
      observerDbl2 = -> calls.push(observerDbl2)
      @observable.observe("event", observerDbl1)
      @observable.observe("event", observerDbl2)

      @observable.notify("event")

      expect(observerDbl1).to.eq calls[0]
      expect(observerDbl2).to.eq calls[1]

    it "should not fail if no observers", ->
      expect(!@observable.notify("event")).to.be.ok

    it "should notify only relevant observers", ->
      calls = []
      @observable.observe "event", -> calls.push("event")
      @observable.observe "other", -> calls.push("other")

      @observable.notify("other")

      expect(calls).to.deep.eq ["other"]
