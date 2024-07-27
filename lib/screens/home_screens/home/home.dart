import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/screens/home_screens/home/widget/infor_user.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_infor.dart';
import 'package:flutter_review/widgets/progress_shared.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> getData() async {
    await Provider.of<ProviderHome>(context, listen: false).getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8),
          child:
              Consumer<ProviderHome>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return const ProgressShared();
              } else {
                if (value.loadUser.isEmpty && value.isLoading == false) {
                  return Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                      ),
                      child: Center(
                        child: Text(value.messageGetData),
                      ),
                    ),
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
                                          onPressed: () async{
                                            // TODO
                                            Navigator.of(context).pop();
                                            await value.deleteData(id: user.id, index: index);
                                            _showMessenger(value.messageDeleteData);
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

  void _showMessenger(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

}
