import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../data/hive_storage.dart';
import '../../data/model/profile.dart';
import '../../data/model/notification.dart';
import '../../logic/logic.dart';

class NotiSetDialog extends StatefulWidget {
  const NotiSetDialog(this.profile, {super.key});
  final Profile profile;

  @override
  State<NotiSetDialog> createState() => _NotiSetDialogState();
}

class _NotiSetDialogState extends State<NotiSetDialog> {
  final TextEditingController _remarkCont = TextEditingController();
  bool _dirty = false;
  DateTime? _dateNTime;

  @override
  void initState() {
    super.initState();
    setState(() {
      _dateNTime = DateTime.now().add(const Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '${widget.profile.name}${Lang.notiSet}',
                  style: CommonStyle.diaryFont,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(Lang.notiTime, style: CommonStyle.labelFont),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? selectedDate = await showDatePicker(
                        context: context,
                        helpText: Lang.notiSet,
                        cancelText: Lang.cancel,
                        confirmText: Lang.confirm,
                        initialDate: _dateNTime!,
                        firstDate: DateTime.now(),
                        lastDate: _dateNTime!.add(const Duration(days: 365)),
                        builder: (_, child) =>
                            CommonStyle.calendarTheme(child!, context),
                      );
                      if (selectedDate == null) return;

                      if (!mounted) return;
                      final TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        helpText: Lang.notiSet,
                        cancelText: Lang.cancel,
                        confirmText: Lang.confirm,
                        hourLabelText: '',
                        minuteLabelText: '',
                        initialTime: TimeOfDay.now(),
                        initialEntryMode: TimePickerEntryMode.inputOnly,
                      );
                      if (selectedTime == null) return;
                      setState(() {
                        _dateNTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      });
                    },
                    child: Row(
                      children: [
                        Text(_dateNTime!.alarm(), style: CommonStyle.labelFont),
                        const SizedBox(width: 4),
                        const Icon(Icons.alarm),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(Lang.notiMemo, style: CommonStyle.labelFont),
              TextField(
                cursorColor: CommonStyle.primaryGray,
                controller: _remarkCont,
                maxLength: 15,
                textAlign: TextAlign.center,
                decoration: CommonStyle.underlineInput(Lang.notiEx),
                onChanged: (_) => setState(() {
                  _dirty = true;
                }),
              ),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(Lang.notiGuide, style: CommonStyle.guideFont),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      Lang.cancel,
                      style: TextStyle(color: CommonStyle.secondGray),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (!_dirty || DateTime.now().isAfter(_dateNTime!)) {
                        return;
                      }
                      final NotiInfo noti = NotiInfo(
                          master: widget.profile.name,
                          notiMoment: _dateNTime!,
                          memo: _remarkCont.text);
                      await NotiHelper.setNoti(noti);
                      await HiveStore.saveCatNoti(widget.profile.id, noti);
                      if (mounted) Navigator.of(context).pop();
                    },
                    child: const Text(Lang.confirm),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NotiDelDialog extends StatelessWidget {
  const NotiDelDialog(this.noti, this.profile, {super.key});
  final NotiInfo noti;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '${noti.master}${Lang.notiSet}',
                  style: CommonStyle.diaryFont,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(Lang.notiTime, style: CommonStyle.labelFont),
                  const SizedBox(width: 20),
                  Text(noti.notiMoment.alarm(), style: CommonStyle.labelFont),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(Lang.notiMemo, style: CommonStyle.labelFont),
                  const SizedBox(width: 20),
                  Text(noti.memo, style: CommonStyle.labelFont),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(Lang.notiDeleteGuide, style: CommonStyle.guideFont),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      await NotiHelper.deleteNoti(noti.notiMoment.notiId());
                      await HiveStore.deleteCatNoti(profile.id);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      Lang.delete,
                      style: TextStyle(color: CommonStyle.secondGray),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(Lang.confirm),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
