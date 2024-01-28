import 'package:app/features/authentication/sign_in_page.dart';
import 'package:app/features/authentication/sign_up_page.dart';
import 'package:app/features/home/home_page.dart';
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
    HomePage.route: (context) => const HomePage(),
    SignInPage.route: (context) => const SignInPage(),
    SignUpPage.route: (context) => const SignUpPage(),
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
