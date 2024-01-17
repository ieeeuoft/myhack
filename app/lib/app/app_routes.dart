import 'package:flutter/material.dart';
import 'package:app/features/profile/profile_page.dart';
import 'package:app/features/team/team_page.dart';
import 'package:app/features/notifications/notifications_page.dart';
import 'package:app/features/schedule/schedule_page.dart';
import 'package:app/features/booking_status/booking_status_page.dart';
import 'package:app/features/hardware/hardware_page.dart';
import 'package:app/features/announcements/announcements_page.dart';
import 'package:app/features/blog/blog_page.dart';

class AppRoutes {

  static Map<String, WidgetBuilder> routes = {
    ProfilePage.route: (context) => const ProfilePage(),
    TeamPage.route: (context) => const TeamPage(),
    NotificationsPage.route: (context) => const NotificationsPage(),
    SchedulePage.route: (context) => const SchedulePage(),
    BookingStatusPage.route: (context) => const BookingStatusPage(),
    HardwarePage.route: (context) => const HardwarePage(),
    AnnouncementsPage.route: (context) => const AnnouncementsPage(),
    BlogPage.route: (context) => const BlogPage(),
  };
}
