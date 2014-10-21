insert = (index, term, string) ->
  if index > 0
    return string.substring(0, index) + term + string.substring(index, string.length)
  else
    return string + term

module.exports.format_date = (date) ->
  meridiem = /\ (a|p)m/
  new_date = new Date(date.replace meridiem, '')

  if isNaN(new_date.getTime())
    new_date = insert(11, '0', (date.replace meridiem, ''))
    new_date = new Date(new_date)

  if (date.match meridiem)?
    am = (date.match /\ am/)?
    if am and new_date.getHours() == 12
      new_date.setHours 0
    else
      new_date.setHours new_date.getHours() + 12

  return new_date
