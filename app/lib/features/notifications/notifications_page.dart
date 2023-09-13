import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifications_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Notifications Page'),
    );
  }
}
