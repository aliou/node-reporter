var assert = require('assert');
var Reporter = require('../lib/reporter');

var reporter = new Reporter( { directory: __dirname + '/data/' } )

describe('Reports', function() {
  describe('#list', function(){
    it('should list all available reports', function() {
      var reports = reporter.list()
      assert.equal(reports.length, 18, "Eighteen reports");
    })
    it('should list all the reports depending on their types', function() {
      var reports = reporter.list({ type: 'notification' })
      assert.equal(reports.length, 15, "Fifteen reports");
    })
    it('should list all the reports depending on their connection', function() {
      var reports = reporter.list({ connection: 'cellular' })
      assert.equal(reports.length, 4, "Four reports");
    })
    it('should list all the reports depending on their date', function() {
      var reports = reporter.list({ date: new Date('2014-03-20') })
      assert.equal(reports.length, 8, "Eight reports");
    })
    it('should list all available reports depending on both their connection and their type', function() {
      var reports = reporter.list({ connection: 'wifi', type: 'sleep' })
      assert.equal(reports.length, 1, "One report");
    })
    it('should list all the reports between two dates', function() {
      var reports = reporter.list({ between: { start: new Date('2014-03-19T20:14:42+0100'), end: new Date('2014-03-20T07:31:15+0100') } })
      assert.equal(reports.length, 5, "Five reports");
    })
  })
  describe('questions', function() {
    it('shoud list all the questions', function() {
      var questions = reporter.questions()
      assert.equal(questions.length, 4, "Four questions");
    })
  })
})
