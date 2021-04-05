import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:renew/screens/timer/timer_screen.dart';

final notificationProvider = StateNotifierProvider<NotificationProvider>(
    (ref) => NotificationProvider());

class NotificationProvider
    extends StateNotifier<FlutterLocalNotificationsPlugin> {
  NotificationProvider() : super(FlutterLocalNotificationsPlugin());

  late BuildContext currentBuildContext;

  Future<void> initialize(BuildContext context) async {
    currentBuildContext = context;

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('app_icon');
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    InitializationSettings initSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    state.initialize(
      initSettings,
      // onSelectNotification: (payload) async {},
    );
  }

  // Notification settings

  Future<void> scheduleNotification(
    Duration fromNow,
    String title,
    String body,
    DateTime scheduledDate,
    bool isReschedule,
  ) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'renew_channel_0',
      'renew_channel',
      'custom_notif_channel',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    IOSNotificationDetails iosDetails =
        IOSNotificationDetails(sound: 'notification.wav');

    if (isReschedule) {
      state.cancel(0);
    }
    state.schedule(
      0,
      title,
      body,
      scheduledDate.add(fromNow),
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelNotification() async => state.cancel(0);
}
