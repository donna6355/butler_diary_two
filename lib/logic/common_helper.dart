String ageCalc(DateTime birth) {
  DateTime now = DateTime.now();

  int years = now.year - birth.year;
  int months = now.month - birth.month;
  int days = now.day - birth.day;

  if (months < 0 || (months == 0 && days < 0)) {
    years--;
    months += (days < 0 ? 11 : 12);
  }

  return years > 0 ? '$years년 $months개월' : '$months개월';
}
