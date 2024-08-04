import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_review/global/api/api_error.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/api_services/home_services.dart';

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

  Future<void> getData({String? key, String? value}) async {
    try {
      final List<UserModel> temp; 
      if( key != null && value != null){
        temp = await _homeServices.getData(key: key, value: value);
        if (value != '') {
        _searchUser = temp;
        checkSearchUser = true;
        checkValue = true;
      }
      }
      else{
        temp = await _homeServices.getData();
        _users = temp;
        isLoading = false;
        checkData = false;
      }
    
      notifyListeners();
    } catch (e) {
      ApiError error = e as ApiError;
      messageGetData = error.message.toString();
      isLoading = false;
      _searchUser = [];
      checkSearchUser = false;
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
}
