import 'package:flutter/material.dart';
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
  final HomeServices _homeService = HomeServices();

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
                  labelText: "Nhập tên bạn muốn thay đổi",
                  hintText: 'Nhập tên',
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFileUser(
                  textController: _controllerGmail,
                  labelText: "Nhập gmail bạn muốn thay đổi",
                  hintText: 'Nhập gmail',
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFileUser(
                  textController: _controllerAddress,
                  labelText: "Nhập địa chỉ bạn muốn thay đổi",
                  hintText: 'Nhập địa chỉ',
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFileUser(
                  textController: _controllerAge,
                  labelText: "Nhập ngày sinh bạn muốn thay đổi",
                  hintText: 'Nhập ngày sinh',
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFileUser(
                  textController: _controllerNationality,
                  labelText: "Nhập quốc tịch bạn muốn thay đổi",
                  hintText: 'Nhập quốc tịch',
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFileUser(
                  textController: _controllerId,
                  labelText: "Nhập id của bạn ",
                  hintText: 'Nhập id',
                  onChanged: (value) {},
                ),
              ),
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

                    _homeService.createData(newUser);

                    Navigator.pop(context);
                  },
                  child: const TextInfor(
                    text: 'Thêm tài khoản',
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
