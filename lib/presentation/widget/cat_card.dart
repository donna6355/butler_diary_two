import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'memo_dialog.dart';
import 'widget.dart';
import '../../core/core.dart';
import '../../data/hive_storage.dart';
import '../../data/model/profile.dart';
import '../../data/model/notification.dart';
import '../../data/model/memo.dart';
import '../../logic/calendar_date.dart';

class CatCards extends StatelessWidget {
  const CatCards({required this.profile, required this.vertical, super.key});
  final Profile profile;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<CalendarDate>(context, listen: false)
                .updateSelectedDate(
              DateTime.now(),
              DateTime.now(),
            );
            Provider.of<CalendarDate>(context, listen: false).resetFormat();
            Navigator.of(context)
                .pushNamed(NamedRoutes.diary, arguments: profile);
          },
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: vertical ? 340 : 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(color: CommonStyle.primaryGray, width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: vertical
                    ? CatCardVertical(profile)
                    : CatCardHorizontal(profile),
              ),
              CatNotiButton(profile),
              CatMemoButton(profile),
            ],
          ),
        ),
        CatMemo(profile)
      ],
    );
  }
}

class CatNotiButton extends StatelessWidget {
  const CatNotiButton(this.profile, {super.key});
  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 24,
        top: 16,
        child: ValueListenableBuilder<Box>(
          valueListenable: Hive.box(Constants.notification).listenable(),
          builder: (_, box, __) {
            final NotiInfo? noti = box.get(profile.id);
            return IconButton(
              icon: Icon(
                Icons.notifications_none_outlined,
                color: noti == null
                    ? CommonStyle.subGray
                    : CommonStyle.primaryGray,
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) {
                    return noti == null
                        ? NotiSetDialog(profile)
                        : NotiDelDialog(noti, profile);
                  }),
            );
          },
        ));
  }
}

class CatMemoButton extends StatelessWidget {
  final Profile profile;
  const CatMemoButton(this.profile, {super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 24,
        top: 52,
        child: ValueListenableBuilder<Box>(
          valueListenable: Hive.box(Constants.memo).listenable(),
          builder: (_, box, __) {
            final Memo? memo = box.get(profile.id);
            return IconButton(
              icon: Icon(
                Icons.sticky_note_2_rounded,
                color: memo == null
                    ? CommonStyle.subGray
                    : CommonStyle.primaryGray,
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) => MemoSetDialog(profile, memo)),
            );
          },
        ));
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

class CatMemo extends StatelessWidget {
  final Profile profile;
  const CatMemo(this.profile, {super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box(Constants.memo).listenable(),
      builder: (_, box, __) {
        final Memo? memo = box.get(profile.id);
        return memo == null
            ? SizedBox.shrink()
            : Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: _markerColor(memo.mark),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(memo.memo,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                            onTap: () => HiveStore.deleteCatMemo(profile.id),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }
}

Color _markerColor(double val) {
  if (val == 1) return Color(0xffFF6961);
  if (val == 2) return Color(0xffFFB347);
  if (val == 3) return Color(0xff77DD77);
  return Color(0xff585858);
}
