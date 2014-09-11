helper = require './helper'

class Snapshot
  @initFromObject = (obj) ->
    snapshot = new @

    for key, value of obj
      snapshot['_' + key] = obj[key]

    snapshot.date = helper.format_date snapshot._date
    Snapshot._alias(snapshot, key) for key in ['battery', 'location']

    snapshot

  # Private: Expose an attribute from a Snapshot object.
  #
  # Returns nothing.
  @_alias: (snapshot, key) ->
    privateKey = '_' + key

    snapshot[key] = snapshot[privateKey]
    snapshot[privateKey] = undefined

module.exports = Snapshot
