import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../data/model/profile.dart';
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
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: _dateNTime!,
                        firstDate: DateTime.now(),
                        lastDate: _dateNTime!.add(const Duration(days: 365)),
                      );
                      if (selectedDate == null) return;

                      if (!mounted) return;
                      final TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDate),
                      );
                      if (selectedTime == null) return;
                    },
                    child: Row(
                      children: [
                        Text(_dateNTime!.alarm(), style: CommonStyle.labelFont),
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
                  if (_dirty)
                    TextButton(
                      onPressed: () => NotiHelper.setNoti(
                        date: _dateNTime!,
                        title: '${widget.profile.name} ${_remarkCont.text}',
                      ),
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

// class NotiDelDialog extends StatelessWidget {
//   const NotiDelDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: ,
//     );
//   }
// }
