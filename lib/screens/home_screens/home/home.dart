import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/screens/home_screens/home/widget/button_dig_log.dart';
import 'package:flutter_review/screens/home_screens/home/widget/infor_user.dart';
import 'package:flutter_review/screens/home_screens/home/widget/show_dia_log.dart';
import 'package:flutter_review/store/home_store.dart';
import 'package:flutter_review/widgets/progress_shared.dart';
import 'package:flutter_review/widgets/show_messenger.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeStore homeStores = HomeStore();

  @override
  void initState() {
    homeStores.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (homeStores.isLoading) {
            return const ProgressShared();
          } else if (homeStores.users.isEmpty) {
            return ShowDiaLog(
              content: homeStores.checkData
                  ? homeStores.messageGetData
                  : 'Không có dữ liệu',
              title: 'Thông báo',
              actions: [
                ButtonDigLog(
                  text: 'OK',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
              color: Colors.blue[100],
            );
          } else {
            return Observer(
              builder: (_) => ListView.builder(
                itemCount: homeStores.users.length,
                itemBuilder: (context, index) {
                  final UserModel user = homeStores.users[index];
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
                                  content: 'Are you sure you want to delete?',
                                  actions: [
                                    ButtonDigLog(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      text: 'Cancel',
                                    ),
                                    ButtonDigLog(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        await homeStores.deleteUser(
                                            id: user.id, index: index);
                                        showCustomMess(
                                          content: homeStores.messageDelete,
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
              ),
            );
          }
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
