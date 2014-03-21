_    = require 'underscore'
fs   = require 'fs'
path = require 'path-extra'

DEFAULT_FOLDER = path.join path.homedir(), 'Dropbox/Apps/Reporter-App/'

module.exports = Reports = (@options = { directory: DEFAULT_FOLDER }) ->
(->
  # Public: Retrieve reports
  #
  # options - The Hash options to filter the results by (default: {}):
  #           :type - The type of notifications (default: all):
  #             ['button', 'buttonAsleep', 'notification', 'sleep', 'wake']
  #           :connection - The network connection of the device when the
  #             report was made (default: all), ['cellular', 'wifi', 'none']
  # cb - A callback responding to the signature `function(err, reports)`
  #
  # Returns an array containing the reports or whatever the callback returns if
  #  a callback is provided.
  #  as a parameter.
  # TODO: Filter by date.
  @list = (options, cb) ->
    [cb, options] = [options, null] if typeof options is 'function'

    reports = []
    directory = @options.directory

    fs.readdirSync(directory).forEach (file) ->
      if file.match /.json$/
        data = fs.readFileSync path.join(directory, file)
        snapshots = JSON.parse(data).snapshots
        _.each snapshots, (report) -> reports.push report

    if options?
      if options.type?
        impetus = ['button', 'buttonAsleep', 'notification', 'sleep', 'wake']
        reports = _.filter reports, (r) ->
          r.reportImpetus? and r.reportImpetus == impetus.indexOf options.type

      if options.connection?
        connections = ['cellular', 'wifi', 'none']
        reports = _.filter reports, (r) ->
          r.connection == connections.indexOf options.connection

    if cb?
      cb null, reports
    else
      reports
).call(Reports.prototype)
