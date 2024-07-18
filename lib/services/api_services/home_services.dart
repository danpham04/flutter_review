import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_review/global/api/api_error.dart';
import 'package:flutter_review/global/api/rest_client.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/repository/home_repository.dart';
import 'package:http/http.dart' as http;

class HomeServices extends HomeRepository {
  final RestClient _restClient =
      RestClient(baseUrl: "https://66879c080bc7155dc0185037.mockapi.io");

  @override
  Future<List<UserModel>> getData() async {
    try {
      final response = await _restClient.get("/datauser");
      if (response is List<dynamic>) {
        final users = response;

        final List<UserModel> loadData = users.map((e) {
          return UserModel.fromMap(e);
        }).toList();

        return loadData;
      }
      throw ApiError.fromResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserModel> createData(UserModel newUser) async {
    try {
      final response = await _restClient.post(
        "/datauser",
        data: newUser.toMap(),
      );
      if (response is Map<String, dynamic>) {
        return UserModel.fromMap(response);
      }
      throw ApiError.fromResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteData(String id) async {
    try {
      final response = await _restClient.delete(
        "/datauser/$id",
      );
      if (response is Map<String, dynamic>) {
        return true;
      }
      throw ApiError.fromResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> searchData(String key, String query) async {
    final tmp = query.toLowerCase();
    try {
      final response = await http.get(Uri.parse(
          'https://66879c080bc7155dc0185037.mockapi.io/datauser/?$key=$query'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<UserModel> searchData = data.map((e) {
          return UserModel.fromMap(e);
        }).toList();

        final List<UserModel> filterData = searchData.where((e) {
          return e.id.toLowerCase().contains(tmp) ||
              e.name!.toLowerCase().contains(tmp) ||
              e.address!.toLowerCase().contains(tmp) ||
              e.mail!.toLowerCase().contains(tmp) ||
              e.nationality!.toLowerCase().contains(tmp);
        }).toList();

        return filterData;
      } else {
        throw Exception('Failed to search data');
      }
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<UserModel> updateData(
      {required UserModel newUser, required String id}) async {
    try {
      final response = await http.put(
        Uri.parse("https://66879c080bc7155dc0185037.mockapi.io/datauser1/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newUser.toMap()),
      );

      if (response.statusCode == 200) {
        return UserModel.fromMap(jsonDecode(response.body));
      } else {
        throw Exception('Fail to update data');
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
