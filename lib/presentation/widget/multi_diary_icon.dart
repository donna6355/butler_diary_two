import 'package:flutter/material.dart';

import '../../core/core.dart';

class MultiDiaryIcon extends StatelessWidget {
  const MultiDiaryIcon({
    required this.value,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.label4,
    super.key,
  });
  final double value;
  final String label1;
  final String label2;
  final String label3;
  final String label4;

  @override
  Widget build(BuildContext context) {
    return DiaryIcon(
      icon: '${fileName[label1]}${value.round()}',
      label: value == 0
          ? label1
          : value == 1
              ? label2
              : value == 2
                  ? label3
                  : label4,
    );
  }
}

class DiaryIcon extends StatelessWidget {
  const DiaryIcon({
    required this.icon,
    required this.label,
    super.key,
  });
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 75,
      margin: const EdgeInsets.only(right: 5, bottom: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            width: 54,
            height: 54,
            child: Image.asset('assets/icon/$icon.png'),
          ),
          Text(
            label,
            style: CommonStyle.diaryIconFont,
          ),
        ],
      ),
    );
  }
}
