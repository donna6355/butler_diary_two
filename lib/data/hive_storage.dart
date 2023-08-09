import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'model/diary.dart';
import 'model/profile.dart';
import 'model/notification.dart';
import '../core/core.dart';

class HiveStore {
  HiveStore._();
  static late Box _catBox;
  static late Box _notiBox;
  static Future<void> initHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDir.path);
    Hive.registerAdapter(DiaryAdapter());
    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(NotiInfoAdapter());
    _catBox = await Hive.openBox(Constants.profile);
    _notiBox = await Hive.openBox(Constants.notification);
    //TODO delete stale noti
  }

  static bool checkMasterName(String name) {
    final List catList = _catBox.values.toList();
    for (var cat in catList) {
      if (cat.name == name) return false;
    }
    return true;
  }

  static Future saveCatProfile(String id, Profile cat) async {
    await _catBox.put(id, cat);
  }

  static Future deleteCatProfile(String id) async {
    await Hive.deleteBoxFromDisk('diary_$id');
    await _catBox.delete(id);
    await _notiBox.delete(id);
  }

  static Future saveCatNoti(String id, NotiInfo notiInfo) async {
    await _notiBox.put(id, notiInfo);
  }

  static Future deleteCatNoti(String id) async {
    //once noti is done, it has to be deleted
    await _notiBox.delete(id);
  }
}
