import 'package:flutter/material.dart';
import 'package:flutter_review/global/api/api_error.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/api_services/home_services.dart';

class ProviderHome extends ChangeNotifier {
  List<UserModel> _loadUser = [];
  final HomeServices _homeServices = HomeServices();
  List<UserModel> get loadUser => _loadUser;
  bool isLoading = true;
  String messageGetData = '';
  String messageDeleteData = '';
  String messageCreateData = '';
  String messageUpdateData = '';

  Future<bool> getData() async {
    try {
      final List<UserModel> temp = await _homeServices.getData();
      _loadUser = temp;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      ApiError error = e as ApiError;
      isLoading = false;
      messageGetData = error.message.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteData({
    required String id,
    required int index,
  }) async {
    try {
      bool checkDeleteUser = await _homeServices.deleteData(id);
      if (checkDeleteUser) {
        messageDeleteData = 'Xóa tài khoản thành công';
        _loadUser.removeAt(index);
        notifyListeners();
      }
      return true;
    } catch (e) {
      ApiError error = e as ApiError;
      messageDeleteData = error.message.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> createData({required UserModel newUser}) async {
    try {
      await _homeServices.createData(newUser);
      messageCreateData = 'Tạo tài khoản thành ${newUser.name} công';
      notifyListeners();
      return true;
    } catch (e) {
      ApiError error = e as ApiError;
      messageCreateData = error.message.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateData(
      {required String id, required UserModel newUser}) async {
    try {
      await _homeServices.updateData(newUser: newUser, id: id);
      messageUpdateData = 'Cập nhật tài khoản ${newUser.name} thành công';
      notifyListeners();
      return true;
    } catch (e) {
      ApiError error = e as ApiError;
      messageUpdateData = error.message.toString();
      // messageUpdateData = "xin chao";
      notifyListeners();
      return false;
    }
  }
}
