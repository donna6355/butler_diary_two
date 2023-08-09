import 'package:flutter/material.dart';

import 'widget.dart';

class ToggleChoice extends StatelessWidget {
  const ToggleChoice({
    required this.choice,
    required this.choiceVal,
    required this.toggleState,
    super.key,
  });
  final String choice;
  final bool choiceVal;
  final Function toggleState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleState(choice),
      child: IconCard(
        label: choice,
        choice: choice,
        selectVal: choiceVal,
      ),
    );
  }
}

class ToggleChoiceRow extends StatelessWidget {
  const ToggleChoiceRow({
    required this.label1,
    required this.label2,
    this.label3,
    this.label4,
    required this.choiceVal1,
    required this.choiceVal2,
    this.choiceVal3,
    this.choiceVal4,
    required this.toggleState,
    this.marginS,
    super.key,
  });

  final String label1;
  final String label2;
  final String? label3;
  final String? label4;
  final bool choiceVal1;
  final bool choiceVal2;
  final bool? choiceVal3;
  final bool? choiceVal4;
  final bool? marginS;
  final Function toggleState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.0,
        bottom: marginS != null ? 10 : 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ToggleChoice(
            choice: label1,
            choiceVal: choiceVal1,
            toggleState: toggleState,
          ),
          ToggleChoice(
            choice: label2,
            choiceVal: choiceVal2,
            toggleState: toggleState,
          ),
          label3 != null
              ? ToggleChoice(
                  choice: label3!,
                  choiceVal: choiceVal3!,
                  toggleState: toggleState,
                )
              : const SizedBox(width: 66),
          label4 != null
              ? ToggleChoice(
                  choice: label4!,
                  choiceVal: choiceVal4!,
                  toggleState: toggleState,
                )
              : const SizedBox(width: 66),
        ],
      ),
    );
  }
}
