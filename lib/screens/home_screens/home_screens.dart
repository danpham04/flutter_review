import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/provider/provider_connectivity.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/screens/home_screens/feed/feed.dart';
import 'package:flutter_review/screens/home_screens/home/home.dart';
import 'package:flutter_review/screens/home_screens/profile/profile.dart';
import 'package:flutter_review/screens/home_screens/settings/settings.dart';
import 'package:flutter_review/screens/home_screens/widget/tab_icon.dart';
import 'package:flutter_review/screens/home_screens/widget/tabbar_home.dart';
import 'package:flutter_review/widgets/app_bar_shared.dart';
import 'package:provider/provider.dart';

class HomeScress extends StatefulWidget {
  const HomeScress({
    super.key,
    this.load = true,
  });
  final bool load;

  @override
  State<HomeScress> createState() => _HomeScressState();
}

class _HomeScressState extends State<HomeScress> {
  @override
  void didChangeDependencies() {
    final ProviderConnectivity provider =
        Provider.of<ProviderConnectivity>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkConnect(provider.messConnect);
    });
    super.didChangeDependencies();
  }

  // late StreamSubscription<List<ConnectivityResult>> subscription;
  // @override
  // void initState() {
  //   subscription = Connectivity()
  //       .onConnectivityChanged
  //       .listen((List<ConnectivityResult> result) {
  //     if (result.contains(ConnectivityResult.mobile)) {
  //       return _checkConnect(
  //           'Quay lại trực tuyến \n Đang sử dụng dữ liệu di động');
  //     } else if (result.contains(ConnectivityResult.wifi)) {
  //       return _checkConnect('Quay lại trực tuyến \n Đang sử dụng wifi');
  //     } else {
  //       return _checkConnect(' Bạn đang không có kết nối mạng');
  //     }
  //   });
  //   super.initState();
  // }

  void _checkConnect(String messenger) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(messenger),
    ));
  }

  // void _checkConnect() {
  //   final connectivityResult = context.read<ProviderConnectivity>().messConnect;
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(connectivityResult),
  //   ));
  // }

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
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          leading: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          titleName: 'Flutter Review',
          centerTitle: true,
          actions: [
            TabIcon(
              icon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // provider.clearSearchUser();
                  Navigator.of(context).pushNamed(AppRoutes.search);
                },
              ),
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
