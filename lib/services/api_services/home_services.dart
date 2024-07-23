import 'package:flutter_review/global/api/api_error.dart';
import 'package:flutter_review/global/api/rest_client.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/repository/home_repository.dart';

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
      final response =
          await _restClient.get("/datauser", queryParameters: {key: query});

      if (response is List<dynamic>) {
        final data = response;

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
      }

      throw ApiError.fromResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserModel> updateData(
      {required UserModel newUser, required String id}) async {
    try {
      final response = await _restClient.put(
        "/datauser1/$id",
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
}
