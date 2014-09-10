fs     = require 'fs'
helper = require './helper'
path   = require 'path-extra'

Snapshot = require './Snapshot'

DEFAULT_FOLDER = path.join path.homedir(), 'Dropbox/Apps/Reporter-App/'

module.exports = Reports = (@options = { directory: DEFAULT_FOLDER }) ->
(->
  # Public: The list of questions and their default values.
  #
  # Returns an array containing the questions and eventually the default values.
  @questions = ->
    return @_questions if @_questions?

    @_questions = null
    files = fs.readdirSync @options.directory
    if files.length
      file = path.join(@options.directory, files[0])
      @_questions = JSON.parse(fs.readFileSync(file)).questions

    @_questions

  # Public: Retrieve snapshots
  #
  # options - The Hash options to filter the results by (default: {}):
  #           :type - The type of notifications (default: all):
  #             ['button', 'buttonAsleep', 'notification', 'sleep', 'wake']
  #           :connection - The network connection of the device when the
  #             report was made (default: all), ['cellular', 'wifi', 'none']
  #           :date - A Date object (default: none)
  #           :between - Interval in between the report(s) is (are).
  # cb - A callback responding to the signature `function(err, reports)`
  #
  # Returns an array containing the reports or whatever the callback returns if
  #  a callback is provided.
  @snapshots = (options, cb) ->
    [cb, options] = [options, null] if typeof options is 'function'
    reports = []

    fs.readdirSync(@options.directory).forEach (file) ->
      if file.match /.json$/
        data = JSON.parse(fs.readFileSync path.join(@options.directory, file))

        @_questions = data.questions unless @_questions?
        data.snapshots.forEach (report) ->
          reports.push Snapshot.initFromObject(report)
    , @

    reports = reportFilter(reports, options)

    if cb?
      cb null, reports
    else
      reports

  # Public: Alias to the `snapshots` method.
  @list = @snapshots
).call(Reports.prototype)

# Private: Filter snapshots.
#
# snapshots - The snapshots to filter.
#
# options   - The Hash options to filter the results by (default: {}):
#             :type - The type of notifications (default: all):
#               ['button', 'buttonAsleep', 'notification', 'sleep', 'wake']
#             :connection - The network connection of the device when the
#               report was made (default: all), ['cellular', 'wifi', 'none']
#             :date - A Date object (default: none)
#             :between - Interval in between the report(s) is (are).
#
# Returns an array containing the filtered reports.
filterSnapshots = (snapshots, options) ->
  if options?
    if options.type?
      impetus = ['button', 'buttonAsleep', 'notification', 'sleep', 'wake']
      snapshots = snapshots.filter (r) ->
        r.reportImpetus? and r.reportImpetus == impetus.indexOf options.type

    if options.connection?
      connections = ['cellular', 'wifi', 'none']
      snapshots = snapshots.filter (r) ->
        r.connection == connections.indexOf options.connection

    if options.date?
      snapshots = snapshots.filter (r) ->
        reportDate = new Date(r.date)
        reportDate.toDateString() == options.date.toDateString()

    if options.between? and options.between.start? and options.between.end?
      snapshots = snapshots.filter (r) ->
        rDate = new Date(r.date)
        +rDate >= +options.between.start and +rDate <= +options.between.end

  snapshots
