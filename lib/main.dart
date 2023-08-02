import 'package:flutter/material.dart';

import 'core/core.dart';
import 'presentation/screen/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Lang.butlerDiary,
      theme: CommonStyle.theme,
      routes: {
        NamedRoutes.home: (_) => const LivingRoom(),
        NamedRoutes.devMsg: (_) => const DevMsg(),
        NamedRoutes.diary: (_) => const DiaryScr(),
        NamedRoutes.diaryEdit: (_) => const DiaryEdit(),
        NamedRoutes.profile: (_) => const ProfileScr(),
        NamedRoutes.profileEdit: (_) => const ProfileEdit(),
      },
    );
  }
}
