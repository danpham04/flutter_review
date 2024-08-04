import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/provider/provider_create.dart';
import 'package:flutter_review/screens/home_screens/home/widget/button_dig_log.dart';
import 'package:flutter_review/screens/home_screens/home/widget/pading_text_field.dart';
import 'package:flutter_review/screens/home_screens/home/widget/show_dia_log.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_infor.dart';
import 'package:flutter_review/widgets/app_bar_shared.dart';
import 'package:flutter_review/widgets/show_messenger.dart';
import 'package:provider/provider.dart';

class CreateInfor extends StatefulWidget {
  const CreateInfor({super.key});

  @override
  State<CreateInfor> createState() => _CreateInforState();
}

class _CreateInforState extends State<CreateInfor> {
  @override
  Widget build(BuildContext context) {
    final ProviderCreate providerCreate = context.watch<ProviderCreate>();
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
              PadingTextField(
                labelText: "Enter the img you want to create",
                hintText: 'Nhập đường dẫn ảnh ',
                textController: providerCreate.controllerImg,
              ),
              PadingTextField(
                labelText: "Enter the name you want to create",
                hintText: 'Nhập tên',
                textController: providerCreate.controllerName,
              ),
              PadingTextField(
                labelText: "Enter the gmail you want to create",
                hintText: 'Nhập gmail',
                textController: providerCreate.controllerGmail,
              ),
              PadingTextField(
                labelText: "Enter the address you want to create",
                hintText: 'Nhập địa chỉ',
                textController: providerCreate.controllerAddress,
              ),
              PadingTextField(
                labelText: "Enter the date of birth you want to create",
                hintText: 'Nhập ngày sinh',
                textController: providerCreate.controllerAge,
              ),
              PadingTextField(
                labelText: "Enter the nationality you want to create",
                hintText: 'Nhập quốc tịch',
                textController: providerCreate.controllerNationality,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 149, 196, 235)),
                  onPressed: () {
                    // await _updateDataUser();
                    _showDialog(providerCreate);
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

  void _showDialog(ProviderCreate provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowDiaLog(
          content: 'Are you sure you want to create the user?',
          title: 'Create user',
          actions: [
            ButtonDigLog(
              text: 'Cancel',
              color: Colors.black,
              onPressed: () => Navigator.of(context).pop(),
            ),
            ButtonDigLog(
              text: 'Create',
              color: Colors.black,
              onPressed: () async {
                Navigator.of(context).pop();
                await _updateDataUser(provider);
                
              },
            )
          ],
        );
      },
    );
  }

  Future<void> _updateDataUser(ProviderCreate provider) async {
    bool success = await provider.createUser();

    if (mounted) {
      showCustomMess(content: provider.messageCreate);
      if (success) {
        await Navigator.of(context).pushNamed(AppRoutes.homeScreens);
      } 
    }
  }

  showCustomMess({required String content}) {
    ShowMessengers.showMessenger(context: context, content: content);
  }
}
