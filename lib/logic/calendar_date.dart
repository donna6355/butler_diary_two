import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../core/constants.dart';

class CalendarDate extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  DateTime get getSelectedDate => _selectedDate;
  DateTime get getFocusedDate => _focusedDate;
  CalendarFormat get getFormat => _calendarFormat;

  Future<bool> moveDate(DismissDirection dir) {
    if (dir == DismissDirection.endToStart) {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
      _focusedDate = _focusedDate.add(const Duration(days: 1));
      notifyListeners();
    } else if (dir == DismissDirection.startToEnd) {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
      _focusedDate = _focusedDate.subtract(const Duration(days: 1));
      notifyListeners();
    }
    return Future.value(false);
  }

  void updateSelectedDate(DateTime focused, DateTime selected) {
    _selectedDate = selected;
    _focusedDate = focused;
    notifyListeners();
  }

  void resetFormat() {
    _calendarFormat = CalendarFormat.week;
    notifyListeners();
  }

  void updateFormat() {
    if (_calendarFormat == CalendarFormat.week) {
      _calendarFormat = CalendarFormat.month;
    } else if (_calendarFormat == CalendarFormat.month) {
      _calendarFormat = CalendarFormat.week;
    }
    notifyListeners();
  }

  String checkDate(DateTime date, double isMarked) {
    if (isMarked > 0) return _colorMarkerHelper(isMarked);
    if (date == _selectedDate) return Img.iconGrayDone;
    if (date.toString().substring(0, 10) ==
        _selectedDate.toString().substring(0, 10)) {
      return Img.iconGrayDone;
    }
    return Img.iconDone;
  }

  String _colorMarkerHelper(double isMarked) {
    if (isMarked == 1.0) return Img.iconRDone;
    if (isMarked == 2.0) return Img.iconYDone;
    if (isMarked == 3.0) return Img.iconGDone;
    return Img.iconDone;
  }
}
