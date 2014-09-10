helper = require './helper'

class Snapshot
  @initFromObject = (obj) ->
    snapshot = new @

    for key, value of obj
      snapshot[key] = obj[key]
     
    snapshot.date = helper.format_date snapshot.date

    snapshot

module.exports = Snapshot
