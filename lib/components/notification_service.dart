import 'package:flutter/material.dart';
import 'package:svoz_odpadu/home_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:svoz_odpadu/detail_page.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('res_notification_app_icon');

    final IOSInitializationSettings iOSInitializationSettings =
        IOSInitializationSettings(
      defaultPresentAlert: false,
      defaultPresentBadge: false,
      defaultPresentSound: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) => Get.to(
        DetailPage(
          payload: payload,
        ),
      ),
    );
  }

  AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    '0',
    'notifikace odspadů',
    enableVibration: true,
    channelDescription: 'Sdružuje notifikace pro všechny odpady',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  //  IOSNotificationDetails _iosNotificationDetails = IOSNotificationDetails(
  //   presentAlert: bool!,
  //   presentBadge: bool,
  //   presentSound: bool,
  //   badgeNumber: int,
  //   attachments: List<IOSNotificationAttachment>,
  //   subtitle: String,
  //       threadIdentifier: String?
  // );

  Future<void> showNotifications() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      "Notification Title",
      "This is the Notification Body!",
      NotificationDetails(android: _androidNotificationDetails),
    );
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }
}
