import 'package:butler_diary_two/core/core.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'calendar_components.dart';
import '../../data/model/diary.dart';
import '../../logic/calendar_date.dart';

class Calendar extends StatelessWidget {
  final Map<String, List<Diary>> events;
  final String masterId;
  final String masterName;
  const Calendar(
      {required this.events,
      required this.masterId,
      required this.masterName,
      super.key});

  List<Diary> _getEventsForDay(DateTime day) {
    return events[day.toString().substring(0, 10)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final CalendarFormat calendarFormat =
        Provider.of<CalendarDate>(context).getFormat;
    final DateTime selected =
        Provider.of<CalendarDate>(context).getSelectedDate;
    final DateTime focused = Provider.of<CalendarDate>(context).getFocusedDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TableCalendar(
          eventLoader: _getEventsForDay,
          firstDay: DateTime(2000),
          lastDay: DateTime(DateTime.now().year + 1, DateTime.now().month,
              DateTime.now().day),
          focusedDay: focused,
          selectedDayPredicate: (day) {
            return isSameDay(selected, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            Provider.of<CalendarDate>(context, listen: false)
                .updateSelectedDate(focusedDay, selectedDay);
          },
          calendarFormat: calendarFormat,
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: CommonStyle.secondGray,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: CommonStyle.primaryGray,
              shape: BoxShape.circle,
            ),
          ),
          daysOfWeekHeight: 20,
          headerStyle: const HeaderStyle(
              titleCentered: true, formatButtonVisible: false),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (_, date, events) {
              return events.isNotEmpty
                  ? Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        Provider.of<CalendarDate>(context).checkDate(date)
                            ? Img.iconGrayDone
                            : Img.iconDone,
                      ),
                    )
                  : null;
            },
          ),
        ),
        TextButton(
          onPressed:
              Provider.of<CalendarDate>(context, listen: false).updateFormat,
          child: Text(
              '${calendarFormat == CalendarFormat.week ? Lang.monthly : Lang.weekly} ${Lang.showCalendar}'),
        ),
        if (_getEventsForDay(selected).isEmpty)
          CalendarNewCard(
            masterId: masterId,
            masterName: masterName,
            selected: selected,
          ),
        if (_getEventsForDay(selected).isNotEmpty)
          CalendarDiaryCard(
            masterId: masterId,
            masterName: masterName,
            dailyData: _getEventsForDay(selected)[0],
          ),
      ],
    );
  }
}
