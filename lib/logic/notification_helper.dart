import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../core/core.dart';
import '../data/model/notification.dart';

class NotiHelper {
  NotiHelper._();

  static Future<void> setNoti(NotiInfo noti) async {
    final remaining = noti.notiMoment.difference(DateTime.now()).inMinutes;
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        Constants.notiId,
        Constants.notiChannel,
        icon: Constants.notiIcon,
        channelDescription: Constants.notiDesc,
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    FlutterLocalNotificationsPlugin().zonedSchedule(
      noti.notiMoment.notiId(),
      '${noti.master} ${noti.memo}',
      Lang.meow,
      tz.TZDateTime.now(tz.local).add(Duration(minutes: remaining)),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> deleteNoti(int id) async {
    await FlutterLocalNotificationsPlugin().cancel(id);
  }
}
