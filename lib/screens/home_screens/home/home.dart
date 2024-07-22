import 'package:flutter/material.dart';
import 'package:flutter_review/global/api/api_error.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/screens/home_screens/home/widget/infor_user.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_infor.dart';
import 'package:flutter_review/services/api_services/home_services.dart';
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
  // List<UserModel> _loadUser = [];
  // final HomeServices _homeServices = HomeServices();

  // Future<void> getData() async {
  //   try {
  //     final List<UserModel> temp = await _homeServices.getData();
  //     setState(() {
  //       _loadUser = temp;
  //     });
  //   } catch (e) {
  //     ApiError error = e as ApiError;
  //     _showMessenger(error.message.toString());
  //   }
  // }

  void _getData() async {
    await Provider.of<ProviderHome>(context, listen: false).getData();
    if (!Provider.of<ProviderHome>(context, listen: false).checkGetData) {
      showCustomMess(
          content: Provider.of<ProviderHome>(context, listen: false).messData);
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
    // dùng Provider.of<ProviderHome>(context, listen: false) sử dụng khi
    // không liên quan trực tiếp đến UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8),
          child:
              // dùng Consumer<ProviderHome>(builder: (context, providerHome, child)
              // khi mà một phần cụ thể của UI được rebuild mỗi khi giá trị trong provider thay đổi.
              Consumer<ProviderHome>(builder: (context, providerHome, child) {
            if (providerHome.users.isEmpty) {
              return const ProgressShared();
            } else {
              return ListView.builder(
                itemCount: providerHome.users.length,
                itemBuilder: (context, index) {
                  final UserModel user = providerHome.users[index];

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
                                arguments: providerHome.users[index]);
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
                                return AlertDialog(
                                  title: const TextInfor(
                                    text: 'Delete User',
                                  ),
                                  content: const TextInfor(
                                      text:
                                          'Are you sure you want to delete ?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // TODO
                                        Navigator.of(context).pop();
                                        // providerHome.deleteUser(
                                        //   id: user.id,
                                        //   index: index,

                                        // );
                                        bool success =
                                            await providerHome.deleteUser(
                                          id: user.id,
                                          index: index,
                                        );

                                        showCustomMess(
                                            content: providerHome.messDelete);
                                      },
                                      child: const Text('Delete'),
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
          })),
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

  // Future<void> _deleteDataUser({
  //   required String id,
  //   required UserModel user,
  //   required index,
  // }) async {
  //   try {
  //     bool checkDeleteUser = await _homeServices.deleteData(id);
  //     if (checkDeleteUser) {
  //       _delete(index);
  //       _showMessenger('Xóa thành công ');
  //     }
  //   } catch (e) {
  //     ApiError error = e as ApiError;
  //     _showMessenger(error.message.toString());
  //     _create(index, user);
  //   }
  // }

  // void _delete(int index) {
  //   setState(() {
  //     _loadUser.removeAt(index);
  //   });
  // }

  // void _create(int index, UserModel data) {
  //   setState(() {
  //     _loadUser[index] = data;
  //   });
  // }
}
