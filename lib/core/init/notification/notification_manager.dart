import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:medication_app_v0/core/init/notification/medication_notification.dart';
import 'package:medication_app_v0/views/home/Calendar/model/reminder.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as t;

class NotificationManager {
  static NotificationManager? _instance;
  static NotificationManager get instance {
    _instance ??= NotificationManager._init();
    return _instance!;
  }

  NotificationManager._init() {
    initNotificationManager();
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidInitializationSettings initializationSettingsAndroid;
  late DarwinInitializationSettings initializationSettingsDarwin;
  late InitializationSettings initializationSettings;

  Future initNotificationManager() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializationSettingsAndroid =
        AndroidInitializationSettings("app_icon");
    initializationSettingsDarwin = DarwinInitializationSettings();
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) async {
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
      if (response.payload != null) {
        print('notification payload: ' + response.payload!);
      }
    });
  }

  Future<void> scheduleNotification(MedicationNotification notification) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "Medication", "Medicine",
        channelDescription: "Medication",
        icon: 'app_icon2',
        largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        badgeNumber: 1);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    final timeZone = TimeZone();

    String timeZoneName = await timeZone.getTimeZoneName();
    print('tzName: $timeZoneName');

   
    await flutterLocalNotificationsPlugin.show(
      notification.notificationID,
      notification.notificationTitle,
      notification.notificationBody,
      platformChannelSpecifics,
      payload: notification.payload,
    );
  }


  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max);
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0,
        'plain title',
        'plain body',
        platformChannelSpecifics,
        payload: 'item x');
  }

  void scheduleReminderNotification(ReminderModel reminder) {
    if (reminder.time.isAfter(DateTime.now())) {
      var random = Random(); // keep this somewhere in a static variable. Just make sure to initialize only once.
      MedicationNotification notification = MedicationNotification(
          notificationTitle: reminder.pillName + " Medication Time",
              notificationID: random.nextInt((pow(2, 31) - 1).toInt()),
          notificationTime: reminder.time,
          notificationBody:
          "${reminder.pillName} -  ${reminder.time.hour}:${reminder.time.minute}",
          payload: "emtpy");
      print("notification scheduled");
        this.scheduleNotification(notification);
    }
  }
}


class TimeZone {
  factory TimeZone() => _this ??= TimeZone._();

  TimeZone._() {
    initializeTimeZones();
  }
  static TimeZone? _this;

  Future<String> getTimeZoneName() async => FlutterNativeTimezone.getLocalTimezone();

  Future<t.Location> getLocation([String? timeZoneName]) async {
    if (timeZoneName == null || timeZoneName.isEmpty) {
      timeZoneName = await getTimeZoneName();
    }
    return t.getLocation(timeZoneName);
  }
}