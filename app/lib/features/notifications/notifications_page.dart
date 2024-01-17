import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  static const String route = '/notifications';

  @override
  Widget build(BuildContext context) {
    final RemoteMessage message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold( appBar: AppBar (
      title: const Text ('Push Notifications'),
    ),
        body: Center (
    child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text ('${message.notification?.title}'),
          Text ('${message.notification?.body}'),
          Text ('${message.data}')
        ]
    )
        )
    );
  }
}
