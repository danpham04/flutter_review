import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_review/global/api/api_error.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_file_user.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_infor.dart';
import 'package:flutter_review/services/api_services/home_services.dart';
import 'package:flutter_review/widgets/app_bar_shared.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key, required this.users});
  final UserModel users;
  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late UserModel _user;
  late TextEditingController _controllerName;
  late TextEditingController _controllerGmail;
  late TextEditingController _controllerAddress;
  late TextEditingController _controllerAge;
  late TextEditingController _controllerNationality;
  late TextEditingController _controllerImg;

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFileUser(
                  textController: _controllerImg,
                  labelText: "Nhập đường dẫn ảnh bạn muốn thay đổi",
                  hintText: 'Nhập đường dẫn ảnh',
                  onChanged: (value) {},
                ),
              ),
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
        return AlertDialog(
          title: const TextInfor(
            text: 'User Update',
          ),
          content: const TextInfor(
              text: 'Are you sure you want to update the user ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _showSnack();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSnack() async {
    try {
      UserModel newUser = UserModel(
        image: _controllerImg.text,
        name: _controllerName.text,
        mail: _controllerGmail.text,
        address: _controllerAddress.text,
        dateOfBirth: _controllerAge.text,
        nationality: _controllerNationality.text,
        id: _user.id,
      );

      await HomeServices().updateData(newUser: newUser, id: _user.id);
      if (mounted) {
        setState(() {
          widget.users.name = _controllerName.text;
          widget.users.mail = _controllerGmail.text;
          widget.users.dateOfBirth = _controllerAge.text;
          widget.users.address = _controllerAddress.text;
          widget.users.nationality = _controllerNationality.text;
          widget.users.image = _controllerImg.text;
        });
        _showMessenger('User ${_controllerName.text} updated successfully!');
        Navigator.of(context).pushNamed(AppRoutes.homeScress);
      }
    } catch (e) {
      ApiError error = e as ApiError;
      if (mounted) {
        
        _showMessenger(error.message.toString());
      }
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Failed to update user. Please try again.'),
      //     ),
      //   );
      // }
    }
  }

  void _showMessenger(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
