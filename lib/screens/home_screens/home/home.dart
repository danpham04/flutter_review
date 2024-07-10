import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/screens/home_screens/home/widget/infor_user.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_infor.dart';
import 'package:flutter_review/services/api_services/home_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.load = true});
  final bool load;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool _load;
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
    _load = widget.load;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_load) {
      getData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
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
                        Navigator.of(context)
                            .pushNamed(AppRoutes.updateData, arguments: user);
                      },
                      backgroundColor: Colors.green,
                      icon: Icons.change_circle,
                      label: 'Change infor',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        // HomeServices().deleteData(user.id);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const TextInfor(
                                text: 'Confirmation Dialog',
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
                                    HomeServices().deleteData(user.id);
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.homeScress,
                                        arguments: false);
                                  },
                                  child: const Text('Confirm'),
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
        Positioned(
          bottom: 40,
          right: 25,
          child: FloatingActionButton(
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
        )
      ],
    );
  }
}
