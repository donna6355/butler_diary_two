import 'package:flutter/material.dart';
import '../../core/core.dart';

class ImgLabel extends StatelessWidget {
  const ImgLabel({
    required this.label,
    required this.choice,
    this.choiceVal,
    this.idx,
    this.selectVal,
    super.key,
  });
  final String label;
  final String choice;
  final double? choiceVal;
  final int? idx;
  final bool? selectVal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: idx == null
              ? selectVal!
                  ? CommonStyle.primaryGray
                  : CommonStyle.subGray
              : choiceVal == idx
                  ? CommonStyle.primaryGray
                  : CommonStyle.subGray,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            width: 54,
            height: 54,
            child:
                Image.asset('assets/icon/${fileName[label]}${idx ?? ''}.png'),
          ),
          selectVal == null
              ? Text(
                  choice,
                  style: TextStyle(
                    fontSize: 13,
                    color: choiceVal == idx
                        ? CommonStyle.primaryGray
                        : CommonStyle.secondGray,
                  ),
                )
              : Text(
                  choice,
                  style: TextStyle(
                    fontSize: 13,
                    color: selectVal!
                        ? CommonStyle.primaryGray
                        : CommonStyle.secondGray,
                  ),
                ),
        ],
      ),
    );
  }
}
