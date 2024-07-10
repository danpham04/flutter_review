import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_file_user.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_infor.dart';
import 'package:flutter_review/services/api_services/home_services.dart';
import 'package:flutter_review/widgets/app_bar_shared.dart';

class CreateInfor extends StatefulWidget {
  const CreateInfor({super.key});

  @override
  State<CreateInfor> createState() => _CreateInforState();
}

class _CreateInforState extends State<CreateInfor> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerGmail = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerNationality = TextEditingController();
  final TextEditingController _controllerId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarShared(
        titleName: 'Create User',
        colors: Colors.blue[300],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFileUser(
                  textController: _controllerName,
                  labelText: "Enter the name you want to add",
                  hintText: 'Nhập tên',
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFileUser(
                  textController: _controllerGmail,
                  labelText: "Enter the gmail you want to add",
                  hintText: 'Nhập gmail',
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFileUser(
                  textController: _controllerAddress,
                  labelText: "Enter the address you want to add",
                  hintText: 'Nhập địa chỉ',
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFileUser(
                  textController: _controllerAge,
                  labelText: "Enter the date of birth you want to add",
                  hintText: 'Nhập ngày sinh',
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFileUser(
                  textController: _controllerNationality,
                  labelText: "Enter the nationality you want to add",
                  hintText: 'Nhập quốc tịch',
                  onChanged: (value) {},
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFileUser(
              //     textController: _controllerId,
              //     labelText: "Nhập id của bạn muốn thêm ",
              //     hintText: 'Nhập id',
              //     onChanged: (value) {},
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 149, 196, 235)),
                  onPressed: () {
                    UserModel newUser = UserModel(
                      image:
                          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/877.jpg",
                      name: _controllerName.text,
                      mail: _controllerGmail.text,
                      address: _controllerAddress.text,
                      dateOfBirth: _controllerAge.text,
                      nationality: _controllerNationality.text,
                      id: _controllerId.text,
                    );

                    HomeServices().createData(newUser);

                    Navigator.of(context)
                        .pushNamed(AppRoutes.homeScress, arguments: false);
                  },
                  child: const TextInfor(
                    text: 'Add User',
                    colorText: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
