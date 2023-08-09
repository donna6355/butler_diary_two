import 'package:flutter/material.dart';
import '../../core/core.dart';
import '../../data/model/diary.dart';

class DiaryLabel extends StatelessWidget {
  const DiaryLabel(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: CommonStyle.diaryLabelFont);
  }
}

class DiaryCardLabel extends StatelessWidget {
  const DiaryCardLabel(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(label),
    );
  }
}

class DiaryDivider extends StatelessWidget {
  const DiaryDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.1)),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    required this.dailyData,
    required this.boxKey,
    required this.masterName,
    super.key,
  });
  final Diary dailyData;
  final String boxKey;
  final String masterName;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          NamedRoutes.diaryEdit,
          arguments: {
            'master': masterName,
            'key': boxKey,
            'date': dailyData.date,
          },
        );
      },
      child: const Column(
        children: [
          Icon(Icons.edit),
          Text(Lang.edit, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
