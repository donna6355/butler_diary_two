import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

  bool checkDate(DateTime date) {
    if (date == _selectedDate) return true;
    if (date.toString().substring(0, 10) ==
        _selectedDate.toString().substring(0, 10)) return true;
    return false;
  }
}
