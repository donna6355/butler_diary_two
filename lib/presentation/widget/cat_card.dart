import 'dart:math';

import 'package:butler_diary_two/core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/profile.dart';
import '../../logic/calendar_date.dart';

class CatCards extends StatelessWidget {
  const CatCards({required this.profile, required this.vertical, super.key});
  final Profile profile;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<CalendarDate>(context, listen: false).updateSelectedDate(
          DateTime.now(),
          DateTime.now(),
        );
        Provider.of<CalendarDate>(context, listen: false).resetFormat();
        Navigator.of(context).pushNamed(NamedRoutes.diary, arguments: profile);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        height: vertical ? 340 : 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: CommonStyle.primaryGray, width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: vertical ? CatCardVertical(profile) : CatCardHorizontal(profile),
      ),
    );
  }
}

class CatCardHorizontal extends StatelessWidget {
  const CatCardHorizontal(this.profile, {super.key});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Center(
              child: Image.asset(
            'assets/img/${profile.photo}${Random().nextInt(5)}.png',
            width: MediaQuery.of(context).size.width / 2,
          )),
        ),
        CatCardCommon(profile, false),
      ],
    );
  }
}

class CatCardVertical extends StatelessWidget {
  const CatCardVertical(this.profile, {super.key});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
              'assets/img/${profile.photo}${Random().nextInt(5)}.png',
              height: 180),
        ),
        const Divider(
          height: 0.1,
          color: CommonStyle.secondGray,
        ),
        CatCardCommon(profile, true),
      ],
    );
  }
}

class CatCardCommon extends StatelessWidget {
  const CatCardCommon(this.profile, this.vertical, {super.key});
  final Profile profile;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              profile.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Text(profile.gender == 1 ? Lang.male : Lang.female),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(profile.birth.calc(twoLine: !vertical)),
          ),
          if (profile.weight != null) Text('${profile.weight}${Lang.kg}'),
          const SizedBox(height: 5),
          if (profile.remark != null)
            Expanded(
              child: Text(
                profile.remark!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }
}
