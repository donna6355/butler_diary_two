import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../core/core.dart';
import 'package:timezone/timezone.dart' as tz;

class NotiHelper {
  NotiHelper._();

  static Future<void> setNoti({
    required DateTime date,
    required String title,
  }) async {
    final remaining = date.difference(DateTime.now()).inMinutes;
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
      date.notiId(),
      title,
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
