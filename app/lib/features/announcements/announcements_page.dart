import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'announcements_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Announcement Page'),
    );
  }
}
