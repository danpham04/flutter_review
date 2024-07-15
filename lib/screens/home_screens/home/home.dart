import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/screens/home_screens/home/widget/infor_user.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_infor.dart';
import 'package:flutter_review/services/api_services/home_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UserModel> _loadUser = [];
  final HomeServices _homeServices = HomeServices();

  Future<void> getData() async {
    final List<UserModel> temp = await _homeServices.getData();
    setState(() {
      _loadUser = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void didChangeDependencies() {
    getData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: _loadUser.length,
          itemBuilder: (context, index) {
            final UserModel user = _loadUser[index];
            return Slidable(
              key: Key(index.toString()),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      // TODO
                      Navigator.of(context).pushNamed(AppRoutes.updateData,
                          arguments: _loadUser[index]);
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
                                text: 'Are you sure you want to delete ?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // TODO
                                  _deleteUser(user: user, index: index);
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
        ),
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

  void _deleteUser({required UserModel user, required index}) {
    try {
      _deleteDataUser(user.id);
      _delete(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User delete successfully ${user.name}!'),
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete user. Please try again.'),
        ),
      );
    }
  }

  Future<void> _deleteDataUser(String id) async {
    try {
      if (await _homeServices.deleteData(id)) {
        final tmp = await _homeServices.getData();
        setState(() {
          _loadUser = tmp;
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  void _delete(int index) {
    setState(() {
      _loadUser.removeAt(index);
    });
  }

  void _create(int index, UserModel data) {
    setState(() {
      _loadUser[index] = data;
    });
  }
}
