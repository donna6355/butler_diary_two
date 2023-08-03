import '../logic/logic.dart';

extension TimeFormat on DateTime {
  String calc() {
    return '$year년 $month월 $day일 ${ageCalc(this)}';
  }
}
