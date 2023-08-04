import 'package:flutter/material.dart';
import '../../core/core.dart';

const Map<String, String> fileName = {
  Lang.indifferent: 'feel',
  Lang.wetN: 'wetf',
  Lang.dryN: 'dryf',
  Lang.waterN: 'water',
  Lang.pooN: 'poo',
  Lang.peeN: 'pee',
  Lang.paste: 'chew',
  Lang.treat: 'treat',
  Lang.can: 'can',
  Lang.etc: 'other',
  Lang.hairBall: 'hair',
  Lang.diarrhea: 'diar',
  Lang.puke: 'puke',
  Lang.destory: 'dest',
  Lang.vet: 'vet',
  Lang.vaccine: 'vac',
  Lang.pill: 'pill',
  Lang.eyedrop: 'eye',
  Lang.hunt: 'hunt',
  Lang.tooth: 'teeth',
  Lang.brush: 'fur',
  Lang.bath: 'bath',
  Lang.claw: 'claw',
  Lang.clean: 'toilet',
};

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
