import 'package:app/features/blog/blog_page.dart';
import 'package:app/features/home/home_page.dart';
import 'package:app/features/profile/profile_page.dart';
import 'package:app/features/team/team_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'features/authentication/sign_in_page.dart';

class TabItem {
  final Widget widget;
  final String route;
  final bool protected;

  TabItem({required this.widget, required this.route, required this.protected});
}


class PageViewer extends StatefulWidget {
  const PageViewer({super.key});

  @override
  _PageViewerState createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<TabItem> _tabs = [
    TabItem(widget: const HomePage(), route: HomePage.route, protected: false),
    TabItem(widget: const BlogPage(), route: BlogPage.route, protected: false),
    TabItem(widget: const TeamPage(), route: TeamPage.route, protected: false),
    TabItem(widget: const ProfilePage(), route: ProfilePage.route, protected: true),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      navigateToPage(context, _tabs[_tabController.index]);
    }
  }

  Future<void> navigateToPage(BuildContext context, TabItem tabItem) async {
    if (!tabItem.protected) {
      Navigator.of(context).pushNamed(tabItem.route);
    }

    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushNamed(tabItem.route);
    } else {
      Navigator.of(context).pushNamed(SignInPage.route, arguments: tabItem.route);
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: _tabs.map((tabItem) => tabItem.widget).toList(),
        ),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.book)),
            Tab(icon: Icon(Icons.group)),
            Tab(icon: Icon(Icons.person)),
          ],
          labelColor: const Color(0xff2B7BBC),
          unselectedLabelColor: const Color(0xff141D1D),
          indicatorColor: const Color(0xff2B7BBC),
        ),
        backgroundColor: const Color(0xffEFEFEF),
      ),
    );
  }
}
