import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Noti {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required FlutterLocalNotificationsPlugin fln,
    required DateTime scheduledTime,
  }) async {
    tz.initializeTimeZones();
    final location =
        tz.getLocation('Europe/Warsaw'); // Zmień strefę czasową na swoją
    final scheduledDateTime = tz.TZDateTime(
      location,
      scheduledTime.year,
      scheduledTime.month,
      scheduledTime.day,
      scheduledTime.hour,
      scheduledTime.minute,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'you_can_name_it_whatever1',
      'channel_name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await fln.zonedSchedule(
      0, // Identyfikator notyfikacji
      title,
      body,
      scheduledDateTime,
      not,
      // androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'custom_notification',
    );
  }
}
