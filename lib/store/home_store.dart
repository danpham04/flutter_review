import 'package:mobx/mobx.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/api_services/home_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  List<UserModel> users = [];

  final HomeServices _homeServices = HomeServices();

  @observable
  bool isLoading = true;

  @observable
  bool checkData = true;

  @observable
  bool checkSearchUser = true;

  @observable
  bool checkValue = false;

  @observable
  String messageGetData = '';

  @observable
  String messageDelete = '';

  @observable
  String messageCreate = '';

  @observable
  String messageUpdate = '';

  @observable
  String messageSearch = '';

  @observable
  List<UserModel> searchUser = [];
  
  @observable
  String key = 'id';
  
  List<String> listTilte = ['ID', 'Name', 'Address', 'Mail', 'Nationality'];

  @action
  Future<void> getData({String? key, String? value}) async {
    try {
      List<UserModel> temp;
      if (key != null && value != null) {
        temp = await _homeServices.getData(key: key, value: value);
        if (value.isNotEmpty) {
          searchUser = temp;
          checkSearchUser = true;
          checkValue = true;
        }
      } else {
        temp = await _homeServices.getData();
        users = temp;
        isLoading = false;
        checkData = false;
      }
      await saveUsers(users);
    } catch (e) {
      isLoading = false;
      searchUser = [];
      checkSearchUser = false;
      users = await listUsersData();
    }
  }

  @action
  Future<bool> deleteUser({required String id, required int index}) async {
    try {
      bool isDeleted = await _homeServices.deleteData(id);
      if (isDeleted) {
        users.removeAt(index);
        messageDelete = 'Xóa thành công';
      }
      return true;
    } catch (e) {
      messageDelete = e.toString();
      return false;
    }
  }

  @action
  void setKey(String newKey) {
    key = newKey;
  }

  @action
  void clearSearchUser() {
    searchUser = [];
  }

  
  Future<void> saveUsers(List<UserModel> users) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userData = jsonEncode(users.map((e) => e.toMap()).toList());
    await prefs.setString('userData', userData);
  }

  
  Future<List<UserModel>> listUsersData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? listUserData = prefs.getString('userData');
    if (listUserData != null) {
      List<dynamic> usersJson = jsonDecode(listUserData);
      List<UserModel> listUsers =
          usersJson.map((e) => UserModel.fromMap(e)).toList();
      return listUsers;
    } else {
      return [];
    }
  }
}
