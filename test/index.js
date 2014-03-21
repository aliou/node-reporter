var assert = require('assert');
var Reporter = require('../lib/reporter');

var mockConfig = {
  directory: __dirname + '/data/'
}

describe('Reports', function() {
  describe('#list', function(){
    it('should list all available reports', function() {
      var reporter = new Reporter(mockConfig)
      var reports = reporter.list()

      assert.equal(reports.length, 18, "Four reports");
    })
    it('should list all the reports depending on their types', function() {
      var reporter = new Reporter(mockConfig)
      var reports = reporter.list({ type: 'notification' })

      assert.equal(reports.length, 15, "Four reports");
    })
    it('should list all the reports depending on their connection', function() {
      var reporter = new Reporter(mockConfig)
      var reports = reporter.list({ connection: 'cellular' })

      assert.equal(reports.length, 4, "Four reports");
    })
    it('should list all available reports depending on both their connection and their type', function() {
      var reporter = new Reporter(mockConfig)
      var reports = reporter.list({ connection: 'wifi', type: 'sleep' })

      assert.equal(reports.length, 1, "Four reports");
    })
    it('should list all available reports within the callback', function() {
      var reporter = new Reporter(mockConfig)
      var reports = reporter.list(function(err, reports) {
        assert.equal(reports.length, 18, "Four reports");
      })
    })
    it('should list all the reports depending on their types within the callback', function() {
      var reporter = new Reporter(mockConfig)
      var reports = reporter.list({ type: 'notification' }, function(err, reports) {
        assert.equal(reports.length, 15, "Four reports");
      })
    })
    it('should list all the reports depending on their connection within the callback', function() {
      var reporter = new Reporter(mockConfig)
      var reports = reporter.list({ connection: 'cellular' }, function(err, reports) {
        assert.equal(reports.length, 4, "Four reports");
      })
    })
    it('should list all available reports depending on both their connection and their type within the callback', function() {
      var reporter = new Reporter(mockConfig)
      var reports = reporter.list({ connection: 'wifi', type: 'sleep' }, function(err, reports) {
        assert.equal(reports.length, 1, "Four reports");
      })
    })
  })
})
