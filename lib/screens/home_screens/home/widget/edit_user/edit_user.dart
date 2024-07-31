import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/screens/home_screens/home/widget/button_dig_log.dart';
import 'package:flutter_review/screens/home_screens/home/widget/pading_text_field.dart';
import 'package:flutter_review/screens/home_screens/home/widget/show_dia_log.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_infor.dart';
import 'package:flutter_review/widgets/app_bar_shared.dart';
import 'package:flutter_review/widgets/show_messenger.dart';
import 'package:provider/provider.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key, required this.users});
  final UserModel users;
  @override
  State<EditUser> createState() => _EditUserState();
}

// TODO: chuyển contronller vào trong provider
// tìm cách khởi tạo provider là một biến và sau đó dùng biến đó truy cập
// vào các phần tử trong provider
class _EditUserState extends State<EditUser> {
  late UserModel _user;
  late TextEditingController _controllerName;
  late TextEditingController _controllerGmail;
  late TextEditingController _controllerAddress;
  late TextEditingController _controllerAge;
  late TextEditingController _controllerNationality;
  late TextEditingController _controllerImg;
  late final ProviderHome _providerHome;

  @override
  void initState() {
    _user = widget.users;
    _controllerName = TextEditingController(text: widget.users.name);
    _controllerGmail = TextEditingController(text: widget.users.mail);
    _controllerAddress = TextEditingController(text: widget.users.address);
    _controllerAge = TextEditingController(text: widget.users.dateOfBirth);
    _controllerNationality =
        TextEditingController(text: widget.users.nationality);
    _controllerImg = TextEditingController(text: widget.users.image);
    _providerHome = Provider.of<ProviderHome>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerGmail.dispose();
    _controllerAge.dispose();
    _controllerAddress.dispose();
    _controllerNationality.dispose();
    _controllerImg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarShared(
        titleName: 'Update User',
        colors: Colors.blue[300],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              PadingTextField(
                labelText: "Enter the name you want to add",
                hintText: 'Nhập đường dẫn ảnh',
                textController: _controllerImg,
              ),
              PadingTextField(
                labelText: "Enter the name you want to add",
                hintText: 'Nhập tên',
                textController: _controllerName,
              ),
              PadingTextField(
                labelText: "Enter the gmail you want to add",
                hintText: 'Nhập gmail',
                textController: _controllerGmail,
              ),
              PadingTextField(
                labelText: "Enter the address you want to add",
                hintText: 'Nhập địa chỉ',
                textController: _controllerAddress,
              ),
              PadingTextField(
                labelText: "Enter the date of birth you want to add",
                hintText: 'Nhập ngày sinh',
                textController: _controllerAge,
              ),
              PadingTextField(
                labelText: "Enter the nationality you want to add",
                hintText: 'Nhập quốc tịch',
                textController: _controllerNationality,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 149, 196, 235)),
                  onPressed: () {
                    _showDialog();
                  },
                  child: const TextInfor(
                    text: 'Update user',
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowDiaLog(
          color: Colors.blue[100],
          content: 'Are you sure you want to update the user ?',
          title: 'User Update',
          actions: [
            ButtonDigLog(
              text: 'Cancel',
              color: Colors.black,
              onPressed: () => Navigator.of(context).pop(),
            ),
            ButtonDigLog(
              color: Colors.black,
              text: 'Create',
              onPressed: () async {
                Navigator.of(context).pop();
                await _editUserData();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> _editUserData() async {
    UserModel newUser = UserModel(
      image: _controllerImg.text,
      name: _controllerName.text,
      mail: _controllerGmail.text,
      address: _controllerAddress.text,
      dateOfBirth: _controllerAge.text,
      nationality: _controllerNationality.text,
      id: _user.id,
    );

    bool success =
        await _providerHome.updateUser(newUser: newUser, id: _user.id);

    if (mounted) {
      if (success) {
        showCustomMess(
            content: 'User ${_controllerName.text} updated successfully!');
        await Navigator.of(context).pushNamed(AppRoutes.homeScress);
      } else {
        showCustomMess(content: _providerHome.messageUpdate);
      }
    }
  }

  showCustomMess({required String content}) {
    ShowMessengers.showMessenger(context: context, content: content);
  }
}
