import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:news/features/profile/domain/repository/settings/settings.dart';
import 'package:news/injection.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
  );

  Future<void> init() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final deepLink = message.data['deep_link'];
      if (deepLink != null && deepLink.isNotEmpty) {
        log('Received deep link: $deepLink');
      }

      final enabled = getIt<SettingsRepository>().getNotificationsEnabled();
      if (!enabled) return;

      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'ic_launcher',
            ),
          ),
        );
      }
    });

    final messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    log('Firebase Messaging Token: $token');
  }

  /// Подписка на push-уведомления
  Future<void> enablePushNotifications() async {
    await FirebaseMessaging.instance.subscribeToTopic('all');
  }

  /// Отключение push-уведомлений
  Future<void> disablePushNotifications() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic('all');
  }
}
