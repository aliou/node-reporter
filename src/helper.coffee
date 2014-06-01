module.exports.format_date = (date) ->
  meridiem = /\ (a|p)m/
  new_date = new Date(date.replace meridiem, '')

  if (date.match meridiem)?
    am = (date.match /\ am/)?
    new_date.setHours 0 if am and new_date.getHours() == 12
    new_date.setHours new_date.getHours() + 12 if (not am) and new_date.getHours() != 12

  return new_date
