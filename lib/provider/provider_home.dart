import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_review/global/api/api_error.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/api_services/home_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderHome extends ChangeNotifier {
  List<UserModel> _users = [];
  final HomeServices _homeServices = HomeServices();
  List<UserModel> get loadUser => _users;
  bool isLoading = true;
  bool checkData = true;
  bool checkSearchUser = true;
  bool checkValue = false;
  String messageGetData = '';
  String messageDelete = '';
  String messageCreate = '';
  String messageUpdate = '';
  String messageSearch = '';

  List<UserModel> _searchUser = [];
  List<UserModel> get searchUserData => _searchUser;
  String key = 'id';
  List<String> listTilte = ['ID', 'Name', 'Address', 'Mail', 'Nationality'];

  // List<UserModel> saveUsersData = [];

  Future<void> getData({String? key, String? value}) async {
    try {
      final List<UserModel> temp;
      if (key != null && value != null) {
        temp = await _homeServices.getData(key: key, value: value);
        if (value != '') {
          _searchUser = temp;
          checkSearchUser = true;
          checkValue = true;
        }
      } else {
        temp = await _homeServices.getData();
        _users = temp;
        isLoading = false;
        checkData = false;
      }
      _users = temp;
      await saveUsers(_users);

      notifyListeners();
    } catch (e) {
      // ApiError error = e as ApiError;
      // messageGetData = error.message.toString();
      isLoading = false;
      _searchUser = [];
      checkSearchUser = false;
      _users = await listUsersData();
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
        messageDelete = 'Xóa thành công';
        notifyListeners();
      }
      return true;
    } catch (e) {
      ApiError error = e as ApiError;
      messageDelete = error.message.toString();
      notifyListeners();
      return false;
    }
  }

  void setKey(String newKey) {
    key = newKey;
    notifyListeners();
  }

  void clearSearchUser() {
    _searchUser = [];
    notifyListeners();
  }

  Future<void> saveUsers(List<UserModel> users) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userData = jsonEncode(users.map((e) => e.toMap()).toList());
    print('==========$userData');
    await prefs.setString('userData', userData);
  }

  Future<List<UserModel>> listUsersData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? listUserData = prefs.getString('userData');
    if (listUserData != null) {
      print('========== đọc dữ lieu da luu');
      List<dynamic> users = jsonDecode(listUserData);
      List<UserModel> listUsers =
          users.map((e) => UserModel.fromMap(e)).toList();
          
      return listUsers;
    } else {
      return [];
    }
  }
}
