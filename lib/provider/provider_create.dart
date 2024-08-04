import 'package:flutter/cupertino.dart';
import 'package:flutter_review/global/api/api_error.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/api_services/home_services.dart';

class ProviderCreate extends ChangeNotifier {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerImg = TextEditingController();
  TextEditingController controllerGmail = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  TextEditingController controllerNationality = TextEditingController();
  final HomeServices _homeServices = HomeServices();
  String messageCreate = '';

  Future<bool> createUser() async {
    UserModel newUser = UserModel(
      image: controllerImg.text,
      name: controllerName.text,
      mail: controllerGmail.text,
      address: controllerAddress.text,
      dateOfBirth: controllerAge.text,
      nationality: controllerNationality.text,
    );
    try {
      await _homeServices.createData(newUser);
      messageCreate = 'Tao nguoi dung thanh cong';
      notifyListeners();
      return true;
    } catch (e) {
      ApiError error = e as ApiError;
      messageCreate = error.message.toString();
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerImg.dispose();
    controllerGmail.dispose();
    controllerAddress.dispose();
    controllerAge.dispose();
    controllerNationality.dispose();
    super.dispose();
  }

}
