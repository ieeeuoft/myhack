import 'dart:convert';

import 'package:app/features/notifications/notifications_page.dart';
import 'package:app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
      'high importance channel', 'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.defaultImportance);

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }


  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // Prevent duplicate notification pages
    navigatorKey.currentState?.popUntil((route) {
      return route.settings.name != NotificationsPage.route;
    });

    navigatorKey.currentState
        ?.pushNamed(NotificationsPage.route, arguments: message);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    // Handle notifications when app is open from a terminated state via notification
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Handle notifications when app is open from background state via notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Receive notification in background in terminated state
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Triggers for messages that arrive in the foreground
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
                _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher'
            )
          ),
        payload: jsonEncode(message.toMap())
      );
    });
  }

  Future initLocalNotifications() async {
    const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(iOS: iOS, android: android);

    // Method that happens when user selects a local notification
    await _localNotifications.initialize(settings,
    onSelectNotification: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload!));
      handleMessage(message);
    });

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);

  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    initPushNotifications();
    initLocalNotifications();
  }
}
