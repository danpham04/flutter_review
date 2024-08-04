import 'package:flutter/cupertino.dart';
import 'package:flutter_review/global/api/api_error.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/api_services/home_services.dart';

class ProviderUpdate extends ChangeNotifier {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerGmail = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  TextEditingController controllerNationality = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerImg = TextEditingController();
  final HomeServices _homeServices = HomeServices();
  String messageUpdate = '';

  void defaultValueText(UserModel user) {
    controllerName.text = user.name;
    controllerGmail.text = user.mail;
    controllerAddress.text = user.address;
    controllerAge.text = user.dateOfBirth;
    controllerNationality.text = user.nationality;
    controllerId.text = user.id;
    controllerImg.text = user.image;
  }

  Future<bool> updateUser({required String id}) async {
    UserModel newUser = UserModel(
      image: controllerImg.text,
      name: controllerName.text,
      mail: controllerGmail.text,
      address: controllerAddress.text,
      dateOfBirth: controllerAge.text,
      nationality: controllerNationality.text,
    );

    try {
      UserModel user = await _homeServices.updateData(newUser: newUser, id: id);
      defaultValueText(user);
      messageUpdate = 'Cap nhat nguoi dung ${user.name} thanh cong';
      notifyListeners();
      return true;
    } catch (e) {
      ApiError error = e as ApiError;
      messageUpdate = error.message.toString();
      notifyListeners();
      return false;
    }
  }
  @override
  void dispose() {
    controllerName.dispose();
    controllerGmail.dispose();
    controllerAddress.dispose();
    controllerAge.dispose();
    controllerNationality.dispose();
    controllerId.dispose();
    controllerImg.dispose();
    super.dispose();
  }
}
