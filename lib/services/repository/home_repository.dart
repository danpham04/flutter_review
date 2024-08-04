import 'package:flutter_review/model/user_model.dart';

abstract class HomeRepository{
  
  Future<List<UserModel>> getData({String? key, String? value});

  Future<bool> deleteData(String id);

  Future<UserModel> updateData({required UserModel newUser,required String id});

  Future<UserModel> createData(UserModel newUser);
  
}
