// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$usersAtom = Atom(name: 'HomeStoreBase.users', context: context);

  @override
  List<UserModel> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<UserModel> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'HomeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$checkDataAtom =
      Atom(name: 'HomeStoreBase.checkData', context: context);

  @override
  bool get checkData {
    _$checkDataAtom.reportRead();
    return super.checkData;
  }

  @override
  set checkData(bool value) {
    _$checkDataAtom.reportWrite(value, super.checkData, () {
      super.checkData = value;
    });
  }

  late final _$checkSearchUserAtom =
      Atom(name: 'HomeStoreBase.checkSearchUser', context: context);

  @override
  bool get checkSearchUser {
    _$checkSearchUserAtom.reportRead();
    return super.checkSearchUser;
  }

  @override
  set checkSearchUser(bool value) {
    _$checkSearchUserAtom.reportWrite(value, super.checkSearchUser, () {
      super.checkSearchUser = value;
    });
  }

  late final _$checkValueAtom =
      Atom(name: 'HomeStoreBase.checkValue', context: context);

  @override
  bool get checkValue {
    _$checkValueAtom.reportRead();
    return super.checkValue;
  }

  @override
  set checkValue(bool value) {
    _$checkValueAtom.reportWrite(value, super.checkValue, () {
      super.checkValue = value;
    });
  }

  late final _$messageGetDataAtom =
      Atom(name: 'HomeStoreBase.messageGetData', context: context);

  @override
  String get messageGetData {
    _$messageGetDataAtom.reportRead();
    return super.messageGetData;
  }

  @override
  set messageGetData(String value) {
    _$messageGetDataAtom.reportWrite(value, super.messageGetData, () {
      super.messageGetData = value;
    });
  }

  late final _$messageDeleteAtom =
      Atom(name: 'HomeStoreBase.messageDelete', context: context);

  @override
  String get messageDelete {
    _$messageDeleteAtom.reportRead();
    return super.messageDelete;
  }

  @override
  set messageDelete(String value) {
    _$messageDeleteAtom.reportWrite(value, super.messageDelete, () {
      super.messageDelete = value;
    });
  }

  late final _$messageCreateAtom =
      Atom(name: 'HomeStoreBase.messageCreate', context: context);

  @override
  String get messageCreate {
    _$messageCreateAtom.reportRead();
    return super.messageCreate;
  }

  @override
  set messageCreate(String value) {
    _$messageCreateAtom.reportWrite(value, super.messageCreate, () {
      super.messageCreate = value;
    });
  }

  late final _$messageUpdateAtom =
      Atom(name: 'HomeStoreBase.messageUpdate', context: context);

  @override
  String get messageUpdate {
    _$messageUpdateAtom.reportRead();
    return super.messageUpdate;
  }

  @override
  set messageUpdate(String value) {
    _$messageUpdateAtom.reportWrite(value, super.messageUpdate, () {
      super.messageUpdate = value;
    });
  }

  late final _$messageSearchAtom =
      Atom(name: 'HomeStoreBase.messageSearch', context: context);

  @override
  String get messageSearch {
    _$messageSearchAtom.reportRead();
    return super.messageSearch;
  }

  @override
  set messageSearch(String value) {
    _$messageSearchAtom.reportWrite(value, super.messageSearch, () {
      super.messageSearch = value;
    });
  }

  late final _$searchUserAtom =
      Atom(name: 'HomeStoreBase.searchUser', context: context);

  @override
  List<UserModel> get searchUser {
    _$searchUserAtom.reportRead();
    return super.searchUser;
  }

  @override
  set searchUser(List<UserModel> value) {
    _$searchUserAtom.reportWrite(value, super.searchUser, () {
      super.searchUser = value;
    });
  }

  late final _$keyAtom = Atom(name: 'HomeStoreBase.key', context: context);

  @override
  String get key {
    _$keyAtom.reportRead();
    return super.key;
  }

  @override
  set key(String value) {
    _$keyAtom.reportWrite(value, super.key, () {
      super.key = value;
    });
  }

  late final _$getDataAsyncAction =
      AsyncAction('HomeStoreBase.getData', context: context);

  @override
  Future<void> getData({String? key, String? value}) {
    return _$getDataAsyncAction
        .run(() => super.getData(key: key, value: value));
  }

  late final _$deleteUserAsyncAction =
      AsyncAction('HomeStoreBase.deleteUser', context: context);

  @override
  Future<bool> deleteUser({required String id, required int index}) {
    return _$deleteUserAsyncAction
        .run(() => super.deleteUser(id: id, index: index));
  }

  late final _$saveUsersAsyncAction =
      AsyncAction('HomeStoreBase.saveUsers', context: context);

  @override
  Future<void> saveUsers(List<UserModel> users) {
    return _$saveUsersAsyncAction.run(() => super.saveUsers(users));
  }

  late final _$listUsersDataAsyncAction =
      AsyncAction('HomeStoreBase.listUsersData', context: context);

  @override
  Future<List<UserModel>> listUsersData() {
    return _$listUsersDataAsyncAction.run(() => super.listUsersData());
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  void setKey(String newKey) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setKey');
    try {
      return super.setKey(newKey);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSearchUser() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.clearSearchUser');
    try {
      return super.clearSearchUser();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
users: ${users},
isLoading: ${isLoading},
checkData: ${checkData},
checkSearchUser: ${checkSearchUser},
checkValue: ${checkValue},
messageGetData: ${messageGetData},
messageDelete: ${messageDelete},
messageCreate: ${messageCreate},
messageUpdate: ${messageUpdate},
messageSearch: ${messageSearch},
searchUser: ${searchUser},
key: ${key}
    ''';
  }
}
