import 'package:hive/hive.dart';

part 'memo.g.dart';

@HiveType(typeId: 3)
class Memo extends HiveObject {
  @HiveField(0)
  DateTime createdAt;

  @HiveField(1)
  String memo;

  @HiveField(2)
  String master;

  @HiveField(27, defaultValue: 0)
  double mark;

  Memo({
    required this.master,
    required this.createdAt,
    required this.memo,
    required this.mark,
  });
}
