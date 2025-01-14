import 'package:flutter/material.dart';
import 'package:flutter_review/screens/home_screens/feed/feed.dart';
import 'package:flutter_review/screens/home_screens/home/home.dart';
import 'package:flutter_review/screens/home_screens/profile/profile.dart';
import 'package:flutter_review/screens/home_screens/settings/settings.dart';
import 'package:flutter_review/screens/home_screens/widget/tab_icon.dart';
import 'package:flutter_review/screens/home_screens/widget/tabbar_home.dart';
import 'package:flutter_review/widgets/app_bar_shared.dart';

class HomeScress extends StatefulWidget {
  const HomeScress({
    super.key,
  });

  @override
  State<HomeScress> createState() => _MyHomeState();
}

class _MyHomeState extends State<HomeScress> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      animationDuration: const Duration(seconds: 1),
      child: Scaffold(
        appBar: AppBarShared(
          heightAppBar: 120,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(185, 225, 231, 1),
              Color.fromARGB(255, 85, 180, 243)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          leading: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          titleName: 'Flutter Review',
          centerTitle: true,
          actions: const [
            TabIcon(
              icon: Icon(Icons.search),
              colorIcon: Colors.white,
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            dividerHeight: 3,
            indicatorWeight: 4,
            tabs: [
              TabbarHome(text: "Home", icon: Icons.home),
              TabbarHome(text: "Feed", icon: Icons.list),
              TabbarHome(text: "Profile", icon: Icons.person),
              TabbarHome(text: "Setting", icon: Icons.settings),
            ],
          ),
        ),
        body: const Center(
          child: TabBarView(
            children: [
              Home(),
              Feed(),
              Profile(),
              Settings(),
            ],
          ),
        ),
      ),
    );
  }
}
