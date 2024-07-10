import 'package:flutter/material.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_infor.dart';
import 'package:flutter_review/widgets/app_bar_shared.dart';

class ShowInfor extends StatelessWidget {
  const ShowInfor({super.key, required this.showUser});
  final UserModel showUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarShared(titleName: 'Information'),
      body:  Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(42.0),
                  child: Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      padding: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 101, 179, 243),
                              Color.fromARGB(255, 237, 212, 235),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image.network(
                          showUser.image??'',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      TextInfor(
                        text: showUser.name??'',
                        sizeText: 25,
                        colorText: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}