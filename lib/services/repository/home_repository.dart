import 'package:flutter_review/model/user_model.dart';

abstract class HomeRepository{
  
  Future<List<UserModel>> getData();

  Future<List<UserModel>> searchData();

  Future<UserModel> deleteData(String id);

  Future<UserModel> updateData();

  Future<UserModel> createData(UserModel newUser);
  
}
