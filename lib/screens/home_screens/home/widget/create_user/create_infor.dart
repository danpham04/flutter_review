import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/screens/home_screens/home/widget/pading_text_field.dart';
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
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerGmail = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerNationality = TextEditingController();
  final TextEditingController _controllerId = TextEditingController();

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerGmail.dispose();
    _controllerAddress.dispose();
    _controllerAge.dispose();
    _controllerNationality.dispose();
    _controllerId.dispose();
    super.dispose();
  }

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
                  onPressed: () async {
                    Navigator.of(context).pushNamed(AppRoutes.homeScress);
                    await _showSnack();
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

  Future<void> _showSnack() async {
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

    bool success = await Provider.of<ProviderHome>(context, listen: false)
        .createUser(newUser: newUser);

    if (mounted) {
      if (success) {
        showCustomMess(content: context.read<ProviderHome>().messageCreate);
      } else {
        showCustomMess(content: context.read<ProviderHome>().messageCreate);
      }
    }
  }

  showCustomMess({required String content}) {
    ShowMessengers.showMessenger(context: context, content: content);
  }
}
