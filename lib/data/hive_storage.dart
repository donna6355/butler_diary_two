import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'model/diary.dart';
import 'model/profile.dart';
import '../core/core.dart';

class HiveStore {
  HiveStore._();
  static late Box catBox;
  static Future<void> initHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDir.path);
    Hive.registerAdapter(DiaryAdapter());
    Hive.registerAdapter(ProfileAdapter());
    catBox = await Hive.openBox(Constants.profile);
  }

  static bool checkMasterName(String name) {
    final List catList = catBox.values.toList();
    for (var cat in catList) {
      if (cat.name == name) return false;
    }
    return true;
  }

  static Future saveCatProfile(String id, Profile cat) async {
    await catBox.put(id, cat);
  }
}
