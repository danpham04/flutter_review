import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/screens/home_screens/home/widget/button_dig_log.dart';
import 'package:flutter_review/screens/home_screens/home/widget/infor_user.dart';
import 'package:flutter_review/screens/home_screens/home/widget/show_dia_log.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_infor.dart';
import 'package:flutter_review/widgets/progress_shared.dart';
import 'package:flutter_review/widgets/show_messenger.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _getData() async {
    await Provider.of<ProviderHome>(context, listen: false).getData();
  }

  @override
  void initState() {
    super.initState();
    _getData();
    // dùng Provider.of<ProviderHome>(context, listen: false) sử dụng khi
    // không liên quan trực tiếp đến UI

    // dùng Consumer<ProviderHome>(builder: (context, providerHome, child)
    // khi mà một phần cụ thể của UI được rebuild mỗi khi giá trị trong provider thay đổi.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Consumer<ProviderHome>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return const ProgressShared();
              } else {
                if (value.loadUser.isEmpty &&
                    value.isLoading == false &&
                    value.checkData == true) {
                  return ShowDiaLog(
                    content: value.messageGetData,
                    title: 'Lỗi',
                    actions: [
                      ButtonDigLog(
                        text: 'OK',
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                    color: Colors.blue[100],
                  );
                } else {
                  if (value.loadUser.isEmpty) {
                    return ShowDiaLog(
                      content: 'Không có dữ liệu ',
                      title: 'Thông báo',
                      actions: [
                        ButtonDigLog(
                          text: 'OK',
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                      color: Colors.blue[100],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: value.loadUser.length,
                      itemBuilder: (context, index) {
                        final UserModel user = value.loadUser[index];
                        return Slidable(
                          key: Key(index.toString()),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  // TODO
                                  Navigator.of(context).pushNamed(
                                      AppRoutes.updateData,
                                      arguments: value.loadUser[index]);
                                },
                                backgroundColor: Colors.green,
                                icon: Icons.change_circle,
                                label: 'Change infor',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ShowDiaLog(
                                        title: 'Delete User',
                                        content:
                                            'Are you sure you want to delete ?',
                                        actions: [
                                          ButtonDigLog(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            text: 'Cancel',
                                          ),
                                          ButtonDigLog(
                                            onPressed: () async {
                                              // TODO
                                              Navigator.of(context).pop();
                                              await value.deleteUser(
                                                  id: user.id, index: index);
                                              showCustomMess(
                                                  content: value.messageDelete);
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
                  }
                }
              }
            },
          )),
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

  showCustomMess({required String content}) {
    ShowMessengers.showMessenger(context: context, content: content);
  }
}
