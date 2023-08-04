import 'package:flutter/material.dart';
import '../../core/core.dart';

class DiaryLabel extends StatelessWidget {
  const DiaryLabel(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: CommonStyle.diaryLabelFont);
  }
}
