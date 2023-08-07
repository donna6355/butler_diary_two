import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/core.dart';
import '../../data/model/diary.dart';
import '../../logic/calendar_date.dart';
import 'diary_card.dart';

class CalendarNewCard extends StatelessWidget {
  const CalendarNewCard({
    required this.masterId,
    required this.masterName,
    required this.selected,
    super.key,
  });
  final String masterName;
  final String masterId;
  final DateTime selected;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (dir) =>
          Provider.of<CalendarDate>(context, listen: false).moveDate(dir),
      child: Container(
        constraints: const BoxConstraints(minHeight: 400),
        width: double.infinity,
        child: Column(
          children: [
            Image.asset(Img.observe, width: 150),
            const Text(Lang.observe, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  NamedRoutes.diaryEdit,
                  arguments: {
                    'master': masterName,
                    'key': masterId,
                    'date': selected.id(),
                  },
                );
              },
              child: const Text(Lang.writeDiary),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarDiaryCard extends StatelessWidget {
  const CalendarDiaryCard({
    required this.masterId,
    required this.masterName,
    required this.dailyData,
    super.key,
  });
  final String masterName;
  final String masterId;
  final Diary dailyData;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (dir) =>
          Provider.of<CalendarDate>(context, listen: false).moveDate(dir),
      child: DiaryCard(
        dailyData: dailyData,
        boxKey: masterId,
        masterName: masterName,
      ),
    );
  }
}
