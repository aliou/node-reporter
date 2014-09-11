assert   = require 'assert'
Reporter = require '../lib/reporter'

reporter = new Reporter { directory: __dirname + '/data/' }
snapshot = reporter.snapshots()[0]

describe 'Snapshot', ->
  describe '#impetus', ->
    it 'shoud return the impetus string', ->
      assert.equal snapshot.impetus(), 'wake'

    it 'shoud return the connection string', ->
      assert.equal snapshot.connection(), 'wifi'

    it 'shoud return true if the report date is in the interval', ->
      start = new Date('2014-03-18T20:14:42+0100')
      end = new Date('2014-03-20T07:31:15+0100')

      assert.ok snapshot.between(start, end)
