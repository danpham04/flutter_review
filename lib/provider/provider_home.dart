import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_review/global/api/api_error.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/api_services/home_services.dart';
import 'package:flutter_review/widgets/show_messenger.dart';

class ProviderHome extends ChangeNotifier {
  List<UserModel> _users = [];
  final HomeServices _homeServices = HomeServices();

  List<UserModel> get users => _users;
  bool checkGetData = false;
  String messData = '';
  String messDelete ='';
  String messCreate = '';

  Future<void> getData() async {
    try {
      final List<UserModel> temp = await _homeServices.getData();
      _users = temp;
      checkGetData = true;
      messData = '';
      notifyListeners();
    } catch (e) {
      ApiError error = e as ApiError;
      messData = error.message.toString();
      checkGetData = false;
      notifyListeners();
    }
  }

  Future<bool> deleteUser({
    required String id,
    required int index,
  }) async {
    try {
      bool isDeleted = await _homeServices.deleteData(id);
      if (isDeleted) {
        _users.removeAt(index);
        messDelete = 'Xóa thành công';
        notifyListeners();
        return true;
      }
    } catch (e) {
      ApiError error = e as ApiError;
      messDelete = e.message.toString();
      notifyListeners();
      return false;
    }
    return false;
  }

  Future<void> createUser({required UserModel newUser}) async{
    try {
      await _homeServices.createData(newUser);
      messCreate = 'Tao nguoi dung thanh cong';
      _users.add(newUser);
      notifyListeners();
    } catch (e) {
      ApiError error = e as ApiError;
      messCreate = error.message.toString();
      notifyListeners();
    }
  }

}
