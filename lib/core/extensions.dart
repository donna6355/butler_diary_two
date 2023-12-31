import '../logic/logic.dart';

extension TimeFormat on DateTime {
  String calc({bool twoLine = false}) {
    return '$year년 $month월 $day일 ${twoLine ? '\n' : ' / '}${ageCalc(this)}';
  }

  String id() {
    return toString().substring(0, 10);
  }

  String title() {
    return toString().substring(0, 19);
  }

  String alarm() {
    return toString().substring(0, 16);
  }

  int notiId() {
    return (millisecondsSinceEpoch / 1000).round();
  }
}

extension Format on String {
  String intoYmd() {
    return '${substring(0, 4)}년 ${substring(5, 7)}월 ${substring(8, 10)}일';
  }
}
