expect   = require('chai').expect
Reporter = require '../lib/reporter'

reporter = new Reporter { directory: __dirname + '/data/' }
snapshot = reporter.snapshots()[0]

describe 'Snapshot', ->
  describe '#impetus', ->
    it 'returns the impetus string', ->
      expect(snapshot.impetus()).to.eq('wake')

    it 'returns nothing if the impetus value is invalid', ->
      snapshot._reportImpetus = -1
      expect(snapshot.impetus()).to.eq('')

  describe '#connection', ->
    it 'shoud return the connection string', ->
      expect(snapshot.connection()).to.eq('wifi')

    it 'returns nothing if the connection value is invalid', ->
      snapshot._connection = -1
      expect(snapshot.impetus()).to.eq('')

  describe '#between', ->
    it 'returns true if the report date is in the interval', ->
      start = new Date('2014-03-18T20:14:42+0100')
      end = new Date('2014-03-20T07:31:15+0100')

      expect(snapshot.between(start, end)).to.be.true

    it 'returns false if the report date is not the interval', ->
      start = new Date('2014-03-21T20:14:42+0100')
      end = new Date('2014-03-22T07:31:15+0100')

      expect(snapshot.between(start, end)).to.be.false
