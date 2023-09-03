import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../data/model/diary.dart';
import 'widget.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({
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
    return Container(
      constraints: const BoxConstraints(minHeight: 400),
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(Img.iconDone, width: 35, height: 35),
                  Text(dailyData.date.intoYmd(), style: CommonStyle.diaryFont),
                ],
              ),
              EditButton(
                dailyData: dailyData,
                boxKey: boxKey,
                masterName: masterName,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Column(
            children: [
              if (dailyData.feel != -1)
                Column(
                  children: [
                    const DiaryDivider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DiaryCardLabel(Lang.feel),
                        MultiDiaryIcon(
                          value: dailyData.feel,
                          label1: Lang.indifferent,
                          label2: Lang.bad,
                          label3: Lang.soso,
                          label4: Lang.good,
                        ),
                      ],
                    ),
                  ],
                ),
              if (dailyData.dryFood != -1 ||
                  dailyData.wetFood != -1 ||
                  dailyData.water != -1)
                Column(
                  children: [
                    const DiaryDivider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DiaryCardLabel(Lang.eat),
                        if (dailyData.wetFood != -1)
                          MultiDiaryIcon(
                            value: dailyData.wetFood,
                            label1: Lang.wetN,
                            label2: Lang.wetS,
                            label3: Lang.wetM,
                            label4: Lang.wetL,
                          ),
                        if (dailyData.dryFood != -1)
                          MultiDiaryIcon(
                            value: dailyData.dryFood,
                            label1: Lang.dryN,
                            label2: Lang.dryS,
                            label3: Lang.dryM,
                            label4: Lang.dryL,
                          ),
                        if (dailyData.water != -1)
                          MultiDiaryIcon(
                            value: dailyData.water,
                            label1: Lang.waterN,
                            label2: Lang.waterS,
                            label3: Lang.waterM,
                            label4: Lang.waterL,
                          ),
                      ],
                    ),
                  ],
                ),
              if (dailyData.waterySnack ||
                  dailyData.drySnack ||
                  dailyData.snack ||
                  dailyData.otherSnack)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dailyData.dryFood == -1 &&
                            dailyData.wetFood == -1 &&
                            dailyData.water == -1
                        ? const DiaryCardLabel(Lang.eat)
                        : const SizedBox(width: 39),
                    if (dailyData.waterySnack)
                      DiaryIcon(
                        icon: '${fileName[Lang.paste]}',
                        label: Lang.paste,
                      ),
                    if (dailyData.drySnack)
                      DiaryIcon(
                        icon: '${fileName[Lang.treat]}',
                        label: Lang.treat,
                      ),
                    if (dailyData.snack)
                      DiaryIcon(
                        icon: '${fileName[Lang.can]}',
                        label: Lang.can,
                      ),
                    if (dailyData.otherSnack)
                      DiaryIcon(
                        icon: '${fileName[Lang.etc]}',
                        label: Lang.etc,
                      ),
                  ],
                ),
              if (dailyData.poo != -1 || dailyData.pee != -1)
                Column(
                  children: [
                    const DiaryDivider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DiaryCardLabel(Lang.out),
                        if (dailyData.poo != -1)
                          MultiDiaryIcon(
                            value: dailyData.poo,
                            label1: Lang.pooN,
                            label2: Lang.pooS,
                            label3: Lang.pooM,
                            label4: Lang.pooL,
                          ),
                        if (dailyData.pee != -1)
                          MultiDiaryIcon(
                            value: dailyData.pee,
                            label1: Lang.peeN,
                            label2: Lang.peeS,
                            label3: Lang.peeM,
                            label4: Lang.peeL,
                          ),
                      ],
                    ),
                  ],
                ),
              if (dailyData.hairBall ||
                  dailyData.diarrhea ||
                  dailyData.vomit ||
                  dailyData.destroy)
                Column(
                  children: [
                    const DiaryDivider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DiaryCardLabel(Lang.watchOut),
                        if (dailyData.hairBall)
                          DiaryIcon(
                            icon: '${fileName[Lang.hairBall]}',
                            label: Lang.hairBall,
                          ),
                        if (dailyData.diarrhea)
                          DiaryIcon(
                            icon: '${fileName[Lang.diarrhea]}',
                            label: Lang.diarrhea,
                          ),
                        if (dailyData.vomit)
                          DiaryIcon(
                            icon: '${fileName[Lang.puke]}',
                            label: Lang.puke,
                          ),
                        if (dailyData.destroy)
                          DiaryIcon(
                            icon: '${fileName[Lang.destroy]}',
                            label: Lang.destroy,
                          ),
                      ],
                    ),
                  ],
                ),
              if (dailyData.vet ||
                  dailyData.vaccine ||
                  dailyData.pill ||
                  dailyData.eyeDrop)
                Column(
                  children: [
                    const DiaryDivider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DiaryCardLabel(Lang.feelBad),
                        if (dailyData.vet)
                          DiaryIcon(
                            icon: '${fileName[Lang.vet]}',
                            label: Lang.vet,
                          ),
                        if (dailyData.vaccine)
                          DiaryIcon(
                            icon: '${fileName[Lang.vaccine]}',
                            label: Lang.vaccine,
                          ),
                        if (dailyData.pill)
                          DiaryIcon(
                            icon: '${fileName[Lang.pill]}',
                            label: Lang.pill,
                          ),
                        if (dailyData.eyeDrop)
                          DiaryIcon(
                            icon: '${fileName[Lang.eyedrop]}',
                            label: Lang.eyedrop,
                          ),
                      ],
                    ),
                  ],
                ),
              if (dailyData.brushTeeth ||
                  dailyData.brushFur ||
                  dailyData.bath ||
                  dailyData.clawCut)
                Column(
                  children: [
                    const DiaryDivider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DiaryCardLabel(Lang.pretty),
                        if (dailyData.brushTeeth)
                          DiaryIcon(
                            icon: '${fileName[Lang.tooth]}',
                            label: Lang.tooth,
                          ),
                        if (dailyData.brushFur)
                          DiaryIcon(
                            icon: '${fileName[Lang.brush]}',
                            label: Lang.brush,
                          ),
                        if (dailyData.bath)
                          DiaryIcon(
                            icon: '${fileName[Lang.bath]}',
                            label: Lang.bath,
                          ),
                        if (dailyData.clawCut)
                          DiaryIcon(
                            icon: '${fileName[Lang.claw]}',
                            label: Lang.claw,
                          ),
                      ],
                    ),
                  ],
                ),
              if (dailyData.hunting || dailyData.toilet)
                Column(
                  children: [
                    const DiaryDivider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DiaryCardLabel(Lang.healty),
                        if (dailyData.hunting)
                          DiaryIcon(
                            icon: '${fileName[Lang.hunt]}',
                            label: Lang.hunt,
                          ),
                        if (dailyData.toilet)
                          DiaryIcon(
                            icon: '${fileName[Lang.clean]}',
                            label: Lang.clean,
                          ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
          if (dailyData.note.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(width: 0.1)),
              ),
              width: double.infinity,
              child: dailyData.note.isNotEmpty ? Text(dailyData.note) : null,
            ),
          if (dailyData.photos.isNotEmpty)
            Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(width: 0.1)),
              ),
              padding: const EdgeInsets.only(top: 10),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: <Widget>[
                  const Text(Lang.evidence),
                  const SizedBox(width: 3),
                  for (var path in dailyData.photos)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => PhotoCarousel(
                            photos: dailyData.photos,
                            idx: dailyData.photos.indexOf(path),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(File(path),
                              fit: BoxFit.cover, width: 54, height: 54),
                        ),
                      ),
                    )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
