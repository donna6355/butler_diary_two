import 'package:flutter/material.dart';
import 'widget.dart';

class MultipleChoice extends StatelessWidget {
  const MultipleChoice({
    required this.choice1,
    required this.choice2,
    required this.choice3,
    required this.choice4,
    required this.choiceVal,
    required this.valueState,
    super.key,
  });
  final String choice1;
  final String choice2;
  final String choice3;
  final String choice4;
  final double choiceVal;
  final Function valueState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => valueState(choice1, 0.0),
            child: IconCard(
              label: choice1,
              choice: choice1,
              choiceVal: choiceVal,
              idx: 0,
            ),
          ),
          GestureDetector(
            onTap: () => valueState(choice1, 1.0),
            child: IconCard(
              label: choice1,
              choice: choice2,
              choiceVal: choiceVal,
              idx: 1,
            ),
          ),
          GestureDetector(
            onTap: () => valueState(choice1, 2.0),
            child: IconCard(
              label: choice1,
              choice: choice3,
              choiceVal: choiceVal,
              idx: 2,
            ),
          ),
          GestureDetector(
            onTap: () => valueState(choice1, 3.0),
            child: IconCard(
              label: choice1,
              choice: choice4,
              choiceVal: choiceVal,
              idx: 3,
            ),
          ),
        ],
      ),
    );
  }
}
