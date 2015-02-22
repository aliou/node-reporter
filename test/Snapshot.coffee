expect   = require('chai').expect
Reporter = require '../lib/reporter'

reporter = new Reporter { directory: __dirname + '/data/' }
snapshot = reporter.snapshots()[0]

describe 'Snapshot', ->
  describe '#impetus', ->
    it 'returns the impetus string', ->
      expect(snapshot.impetus()).to.eq('wake')

  describe '#connection', ->
    it 'shoud return the connection string', ->
      expect(snapshot.connection()).to.eq('wifi')

  describe '#between', ->
    it 'returns true if the report date is in the interval', ->
      start = new Date('2014-03-18T20:14:42+0100')
      end = new Date('2014-03-20T07:31:15+0100')

      expect(snapshot.between(start, end)).to.be.true
