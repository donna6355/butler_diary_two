import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../core/core.dart';
import '../data/model/notification.dart';

class NotiHelper {
  NotiHelper._();

  static void _checckPermission() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> setNoti(NotiInfo noti) async {
    _checckPermission();
    final remaining = noti.notiMoment.difference(DateTime.now()).inMinutes + 1;
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
      id: noti.notiMoment.notiId(),
      scheduledDate:
          tz.TZDateTime.now(tz.local).add(Duration(minutes: remaining)),
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exact,
      title: '${noti.master} ${Lang.master} ${noti.memo}',
      body: Lang.meow,
    );
  }

  static Future<void> deleteNoti(int id) async {
    await FlutterLocalNotificationsPlugin().cancel(id: id);
  }
}
