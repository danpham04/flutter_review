import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/screens/home_screens/home/widget/button_dig_log.dart';
import 'package:flutter_review/screens/home_screens/home/widget/infor_user.dart';
import 'package:flutter_review/screens/home_screens/home/widget/show_dia_log.dart';
import 'package:flutter_review/widgets/progress_shared.dart';
import 'package:flutter_review/widgets/show_messenger.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.providerHome});
  final ProviderHome providerHome;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final ProviderHome _providerHome = widget.providerHome;

  @override
  void initState() {
    super.initState();
    // _providerHome = Provider.of<ProviderHome>(context, listen: false);
    // _getData();

  }

  void _getData() async {
    await _providerHome.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Consumer<ProviderHome>(
              builder: (context, value, child) {
                return _providerHome.isLoading
                    ? const ProgressShared()
                    : _providerHome.loadUser.isEmpty
                        ? _providerHome.checkData
                            ? ShowDiaLog(
                                content: _providerHome.messageGetData,
                                title: 'Lỗi',
                                actions: [
                                  ButtonDigLog(
                                    text: 'OK',
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                                color: Colors.blue[100],
                              )
                            : ShowDiaLog(
                                content: 'Không có dữ liệu',
                                title: 'Thông báo',
                                actions: [
                                  ButtonDigLog(
                                    text: 'OK',
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                                color: Colors.blue[100],
                              )
                        : ListView.builder(
                            itemCount: _providerHome.loadUser.length,
                            itemBuilder: (context, index) {
                              final UserModel user =
                                  _providerHome.loadUser[index];
                              return Slidable(
                                key: Key(index.toString()),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        Navigator.of(context).pushNamed(
                                            AppRoutes.updateData,
                                            arguments: user);
                                      },
                                      backgroundColor: Colors.green,
                                      icon: Icons.change_circle,
                                      label: 'Change infor',
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        // _showDigLogDelete(user: user, index: index);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ShowDiaLog(
                                              title: 'Delete User',
                                              content:
                                                  'Are you sure you want to delete?',
                                              actions: [
                                                ButtonDigLog(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  text: 'Cancel',
                                                ),
                                                ButtonDigLog(
                                                  onPressed: () async {
                                                    Navigator.of(context)
                                                        .pushNamed(AppRoutes
                                                            .homeScress);
                                                    await _providerHome
                                                        .deleteUser(
                                                            id: user.id,
                                                            index: index);
                                                    showCustomMess(
                                                      content: _providerHome
                                                          .messageDelete,
                                                    );
                                                  },
                                                  text: 'Delete',
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: InforUser(users: user),
                              );
                            },
                          );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.createData);
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  void showCustomMess({required String content}) {
    ShowMessengers.showMessenger(context: context, content: content);
  }
}
