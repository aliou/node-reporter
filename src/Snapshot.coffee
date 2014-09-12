helper = require './helper'

class Snapshot
  # Public: Initialize the Snapshot object using object.
  # Will take all the attributes / keys of the argument object and add them as
  #  private attributes in the Snapshot object
  #
  # obj - The deserialized object from JSON.
  @initFromObject = (obj) ->
    snapshot = new @

    for key, value of obj
      snapshot['_' + key] = obj[key]

    snapshot.date = helper.format_date snapshot._date
    alias key for key in ['battery', 'location']

    snapshot

  # Public: Get the snapshot impetus (the type of notification).
  #
  # Returns the impetus String.
  impetus: ->
    ['button', 'buttonAsleep', 'notification', 'sleep', 'wake'][@_reportImpetus]

  # Public: Get the device connection during the snapshot.
  #
  # Returns the connection String.
  connection: ->
    ['cellular', 'wifi', 'none'][@_connection]

  # Public: Whether or not the snapshot date is in a interval.
  #
  # Returns a Boolean.
  between: (start, end) ->
    +@date >= +start and +@date <= +end

  # Private: Expose an attribute from a Snapshot object.
  #
  # Returns nothing.
  alias = (key) ->
    privateKey = '_' + key

    @[key] = @[privateKey]
    @[privateKey] = undefined

module.exports = Snapshot
