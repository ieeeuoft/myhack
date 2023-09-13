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
  static const String profile = '/profile';
  static const String team = '/team';
  static const String notifications = '/notifications';
  static const String schedule = '/schedule';
  static const String bookingStatus = '/booking_status';
  static const String hardware = '/hardware';
  static const String announcements = '/announcements';
  static const String blog = '/blog';

  static Map<String, WidgetBuilder> routes = {
    profile: (context) => const ProfilePage(),
    team: (context) => const TeamPage(),
    notifications: (context) => const NotificationsPage(),
    schedule: (context) => const SchedulePage(),
    bookingStatus: (context) => const BookingStatusPage(),
    hardware: (context) => const HardwarePage(),
    announcements: (context) => const AnnouncementsPage(),
    blog: (context) => const BlogPage(),
  };
}
