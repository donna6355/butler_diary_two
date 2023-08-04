import 'package:flutter/material.dart';

import '../logic/logic.dart';

extension TimeFormat on DateTime {
  String calc({bool twoLine = false}) {
    return '$year년 $month월 $day일 ${twoLine ? '\n' : ' / '}${ageCalc(this)}';
  }
}

extension ContextExtensions on BuildContext {
  bool get mounted {
    try {
      widget;
      return true;
    } catch (e) {
      return false;
    }
  }
}
