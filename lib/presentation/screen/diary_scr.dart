import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/core.dart';
import '../../data/model/profile.dart';
import '../../data/model/diary.dart';
import '../widget/widget.dart';

class DiaryScr extends StatelessWidget {
  const DiaryScr({super.key});

  @override
  Widget build(BuildContext context) {
    final Profile master =
        ModalRoute.of(context)!.settings.arguments as Profile;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('${master.name} ${Lang.diary}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).popAndPushNamed(
              NamedRoutes.profile,
              arguments: master,
            ),
            child: const Text(Lang.profile),
          ),
        ],
      ),
      body: FutureBuilder(
          future: Hive.openBox('diary_${master.id}'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child:
                    CircularProgressIndicator(color: CommonStyle.primaryGray),
              );
            }
            return ValueListenableBuilder<Box>(
              valueListenable: Hive.box('diary_${master.id}').listenable(),
              builder: (context, box, _) {
                List writtenStringDates = box.keys.toList();
                Map<String, List<Diary>> writtenDate = {};
                for (var key in writtenStringDates) {
                  writtenDate[key] = [box.get(key)];
                }
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Calendar(
                        events: writtenDate,
                        masterId: master.id,
                        masterName: master.name),
                  ],
                );
              },
            );
          }),
    );
  }
}
