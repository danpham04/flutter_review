import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/provider/provider_connectivity.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/screens/home_screens/feed/feed.dart';
import 'package:flutter_review/screens/home_screens/home/home.dart';
import 'package:flutter_review/screens/home_screens/home/widget/show_dia_log.dart';
import 'package:flutter_review/screens/home_screens/profile/profile.dart';
import 'package:flutter_review/screens/home_screens/settings/settings.dart';
import 'package:flutter_review/screens/home_screens/widget/tab_icon.dart';
import 'package:flutter_review/screens/home_screens/widget/tabbar_home.dart';
import 'package:flutter_review/widgets/app_bar_shared.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({
    super.key,
    this.load = true,
  });
  final bool load;

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  late ProviderHome providerHome;
  @override
  void initState() {
    providerHome = Provider.of<ProviderHome>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final ProviderConnectivity provider =
        Provider.of<ProviderConnectivity>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.check) {
        providerHome.getData();
      } else {
        (providerHome.loadUser.isEmpty && providerHome.checkData)
            ? _showDigLog(
                title: 'Thông báo',
                content:
                    'Bạn đã Không có kết nối, không có dữ liệu đã lưu trên máy',
                action: [
                  CupertinoDialogAction(
                      child: const Text('Ok'),
                      onPressed: () {
                        providerHome.getData();
                        Navigator.of(context).pop();
                      })
                ],
              )
            : _showDigLog(
                title: 'Thông báo',
                content: 'Bạn đã mất kết nối, hiển thị dữ liệu đã lưu ',
                action: [
                  CupertinoDialogAction(
                      child: const Text('Ok'),
                      onPressed: () {
                        providerHome.getData();
                        Navigator.of(context).pop();
                      })
                ],
              );
      }
      _checkConnect(provider.messConnect);
    });
    super.didChangeDependencies();
  }

  void _checkConnect(String messenger) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(messenger),
    ));
  }

  void _showDigLog(
      {required String title, required String content, List<Widget>? action}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowDiaLog(
          title: title,
          content: content,
          actions: action,
        );
      },
    );
  }

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
        body: Center(
          child: TabBarView(
            children: [
              Home(
                providerHome: providerHome,
              ),
              const Feed(),
              const Profile(),
              const Settings(),
            ],
          ),
        ),
      ),
    );
  }
}
