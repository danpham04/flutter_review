import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/provider/provider_update.dart';
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProviderUpdate>().defaultValueText(widget.users);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProviderUpdate providerUpdate = context.watch<ProviderUpdate>();
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
                labelText: "Enter the img you want to add",
                hintText: 'Nhập đường dẫn ảnh ',
                textController: providerUpdate.controllerImg,
              ),
              PadingTextField(
                labelText: "Enter the name you want to add",
                hintText: 'Nhập tên',
                textController: providerUpdate.controllerName,
              ),
              PadingTextField(
                labelText: "Enter the gmail you want to add",
                hintText: 'Nhập gmail',
                textController: providerUpdate.controllerGmail,
              ),
              PadingTextField(
                labelText: "Enter the address you want to add",
                hintText: 'Nhập địa chỉ',
                textController: providerUpdate.controllerAddress,
              ),
              PadingTextField(
                labelText: "Enter the date of birth you want to add",
                hintText: 'Nhập ngày sinh',
                textController: providerUpdate.controllerAge,
              ),
              PadingTextField(
                labelText: "Enter the nationality you want to add",
                hintText: 'Nhập quốc tịch',
                textController: providerUpdate.controllerNationality,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 149, 196, 235)),
                  onPressed: () {
                    _showDialog(providerUpdate);
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

  void _showDialog(ProviderUpdate provider) {
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
                await _editUserData(provider);
              },
            )
          ],
        );
      },
    );
  }

  Future<void> _editUserData(ProviderUpdate provider) async {
    bool success = await provider.updateUser(id: widget.users.id);

    if (mounted) {
      showCustomMess(content: provider.messageUpdate);
      if (success) {
        await Navigator.of(context).pushNamed(AppRoutes.homeScress);
      }
    }
  }

  showCustomMess({required String content}) {
    ShowMessengers.showMessenger(context: context, content: content);
  }
}
