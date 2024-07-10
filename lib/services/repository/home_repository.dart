import 'package:flutter_review/model/user_model.dart';

abstract class HomeRepository{
  
  Future<List<UserModel>> getData();

  Future<List<UserModel>> searchData();

  Future<bool> deleteData(String id);

  Future<UserModel> updateData(UserModel newUser, String id);

  Future<UserModel> createData(UserModel newUser);
  
}
