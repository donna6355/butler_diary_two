import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'model/diary.dart';
import 'model/profile.dart';
import '../core/core.dart';

Future<void> initHive() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);
  Hive.registerAdapter(DiaryAdapter());
  Hive.registerAdapter(ProfileAdapter());
  await Hive.openBox(Constants.profile);
}
