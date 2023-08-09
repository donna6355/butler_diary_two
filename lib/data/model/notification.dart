import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 0)
class NotiInfo extends HiveObject {
  @HiveField(0)
  DateTime notiMoment;

  @HiveField(1)
  String memo;

  @HiveField(2)
  String master;

  NotiInfo({
    required this.master,
    required this.notiMoment,
    required this.memo,
  });
}
