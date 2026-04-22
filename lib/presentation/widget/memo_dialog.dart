import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../data/hive_storage.dart';
import '../../data/model/memo.dart';
import '../../data/model/profile.dart';
import 'widget.dart';

class MemoSetDialog extends StatefulWidget {
  final Profile profile;
  final Memo? memo;
  const MemoSetDialog(this.profile, this.memo, {super.key});

  @override
  State<MemoSetDialog> createState() => _MemoSetDialogState();
}

class _MemoSetDialogState extends State<MemoSetDialog> {
  final TextEditingController _memoCont = TextEditingController();
  bool _dirty = false;
  double _mark = 0;

  @override
  void initState() {
    super.initState();
    if (widget.memo != null) {
      setState(() {
        _memoCont.text = widget.memo!.memo;
        _mark = widget.memo!.mark;
      });
    }
  }

  void _setMark(double mark) {
    setState(() {
      _mark = mark;
      _dirty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '${widget.profile.name}${Lang.memoSet}',
                    style: CommonStyle.diaryFont,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(Lang.memoColor, style: CommonStyle.labelFont),
                ColorSelect(_setMark, _mark),
                const SizedBox(height: 8),
                const Text(Lang.memo, style: CommonStyle.labelFont),
                const SizedBox(height: 8),
                TextField(
                  cursorColor: CommonStyle.primaryGray,
                  controller: _memoCont,
                  maxLength: 200,
                  maxLines: 5,
                  decoration: CommonStyle.outlineInput(Lang.memoHint),
                  onChanged: (_) => setState(() {
                    _dirty = true;
                  }),
                ),
                const SizedBox(height: 16),
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
                        if (!_dirty || _memoCont.text.isEmpty) {
                          return;
                        }
                        final Memo memo = Memo(
                            createdAt: DateTime.now(),
                            master: widget.profile.name,
                            memo: _memoCont.text,
                            mark: _mark);
                        await HiveStore.saveCatMemo(widget.profile.id, memo);
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
      ),
    );
  }
}
