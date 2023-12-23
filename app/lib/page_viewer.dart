import 'package:app/features/blog/blog_page.dart';
import 'package:app/features/home/home_page.dart';
import 'package:app/features/profile/profile_page.dart';
import 'package:app/features/team/team_page.dart';
import 'package:flutter/material.dart';

class PageViewer extends StatelessWidget {
  const PageViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4, // make sure that this matches the amount of pages
      child: Scaffold(
      body: TabBarView(
        children:[
          HomePage(),
          BlogPage(),
          TeamPage(),
          ProfilePage(),
        ]
      ),
      bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home)
            ),
            Tab(
              icon: Icon(Icons.book)
            ),
            Tab(
              icon: Icon(Icons.group)
            ),
            Tab(
              icon: Icon(Icons.person)
            ),
          ],
          labelColor: Color(0xff2B7BBC),
          unselectedLabelColor: Color(0xff141D1D),
          indicatorColor: Color(0xff2B7BBC),
        ),
        backgroundColor: Color(0xffEFEFEF),
      ),
    );
    }
}
