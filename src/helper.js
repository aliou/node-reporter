export function formatDate(date) {
  const meridiem = /\ (a|p)m/;
  let newDate = new Date(date.replace(meridiem, ''));

  if (date.match(meridiem)) {
    const morning = date.match(/\ am/);

    if (morning && newDate.getHours() == 12) {
      newDate.setHours(0);
    } else {
      newDate.setHours(newDate.getHours() + 12);
    }
  }

  return newDate;
}
