import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotification {
  LocalNotification._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<bool> checkNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isRestricted || status.isDenied) {
      var result = await Permission.notification.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  static Future<void> initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    bool isPermissionGrandted = await checkNotificationPermission();
    if (isPermissionGrandted) {
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    } else {
      throw Exception("알림권한이 부여되지 않았습니다.");
    }
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
