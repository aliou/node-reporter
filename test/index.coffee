assert   = require 'assert'
Reporter = require '../lib/reporter'

reporter = new Reporter { directory: __dirname + '/data/' }

describe 'Reports', ->
  describe '#list', ->
    it 'shoud list all available reports', ->
      reports = reporter.list()
      assert.equal reports.length, 18, 'Eighteen reports'

    it 'should list all the reports depending on their types', ->
      reports = reporter.list type: 'notification'
      assert.equal reports.length, 15, 'Eighteen reports'

    it 'should list all the reports depending on their connection', ->
      reports = reporter.list connection: 'cellular'
      assert.equal reports.length, 4, 'Eighteen reports'

    it 'should list all the reports depending on their date', ->
      reports = reporter.list date: new Date('2014-03-20')
      assert.equal reports.length, 8, 'Eighteen reports'

    it 'should list all available reports depending on both their connection and their type', ->
      reports = reporter.list connection: 'wifi', type: 'sleep'
      assert.equal reports.length, 1, 'Eighteen reports'

    it 'should list all the reports between two dates', ->
      start = new Date('2014-03-19T20:14:42+0100')
      end = new Date('2014-03-20T07:31:15+0100')
      reports = reporter.list between: { start: start, end: end }

      assert.equal reports.length, 5, 'Eighteen reports'

  describe '#questions', ->
    it 'should list all the questions', ->
      questions = reporter.questions()
      assert.equal questions.length, 4, 'Four questions'
