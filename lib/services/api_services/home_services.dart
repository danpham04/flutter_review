import 'dart:convert';

import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/repository/home_repository.dart';
import 'package:http/http.dart' as http;

class HomeServices extends HomeRepository {
  @override
  Future<UserModel> createData(UserModel newUser) async {
   try {
      final response = await http.post(
        Uri.parse(
            "https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users/user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newUser.toMap()),
      );
      if (response.statusCode == 201) {
        return newUser;
      } else {
        throw Exception('Fail create data');
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<UserModel>> getData() async {
    try {
      final response = await http.get(
          Uri.parse('https://66879c080bc7155dc0185037.mockapi.io/datauser'));
      final data = jsonDecode(response.body);
      final users = data as List<dynamic>;

      final List<UserModel> loadData = users.map((e) {
        return UserModel.fromMap(e);
      }).toList();

      return loadData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> deleteData(String id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> searchData() {
    // TODO: implement searchData
    throw UnimplementedError();
  }

  @override
  Future<UserModel> updateData() {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
