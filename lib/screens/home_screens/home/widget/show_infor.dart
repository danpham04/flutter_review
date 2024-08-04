import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_infor.dart';
import 'package:flutter_review/services/api_services/home_services.dart';
import 'package:flutter_review/widgets/app_bar_shared.dart';

class ShowInfor extends StatelessWidget {
  const ShowInfor({super.key, required this.showUser});
  final UserModel showUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarShared(
        titleName: 'Information',
        colors: Colors.blue[250],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(42.0),
            child: Center(
              child: Container(
                width: 330,
                height: 310,
                padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 101, 179, 243),
                    Color.fromARGB(255, 237, 212, 235),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Column(
                    children: [
                      TextInfor(
                        text: 'Gmail: ${showUser.mail}',
                        sizeText: 15,
                      ),
                      TextInfor(text: 'Địa chỉ: ${showUser.address}'),
                      TextInfor(text: 'Năm sinh: ${showUser.dateOfBirth}'),
                      TextInfor(text: 'Quốc tịch: ${showUser.nationality}'),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      AppRoutes.updateData,
                                      arguments: showUser);
                                },
                                child: const TextInfor(text: 'Edit User')),
                            ElevatedButton(
                                onPressed: () {
                                  _confirmDelete(context);
                                },
                                child: const TextInfor(text: 'Delete User'))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 260.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      showUser.image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  TextInfor(
                    text: showUser.name,
                    sizeText: 25,
                    colorText: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.homeScreens);
                HomeServices().deleteData(showUser.id);
              },
            ),
          ],
        );
      },
    );
  }
}
