import 'package:flutter_review/global/api/api_error.dart';
import 'package:flutter_review/global/api/rest_client.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/repository/home_repository.dart';

class HomeServices extends HomeRepository {
  final RestClient _restClient =
      RestClient(baseUrl: "https://66879c080bc7155dc0185037.mockapi.io");

  @override
  Future<List<UserModel>> getData({String? key, String? value}) async {
    try {
      final pragma = (key != null && value != null) ? {key: value} : null;
      final response =
          await _restClient.get("/datauser", queryParameters: pragma);
      if (response is List<dynamic>) {
        final List<UserModel> loadData = response.map((e) {
          return UserModel.fromMap(e);
        }).toList();
        if (key != null && value != null) {
          final temp = value.toLowerCase();
          return loadData.where((e) {
            return e.id.toLowerCase().contains(temp) ||
                e.name!.toLowerCase().contains(temp) ||
                e.address!.toLowerCase().contains(temp) ||
                e.mail!.toLowerCase().contains(temp) ||
                e.nationality!.toLowerCase().contains(temp);
          }).toList();
        }
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
        // options: Options(
        //   // contentType: Headers.jsonContentType
        //   // headers: {
        //   //   'Content-Type': 'application/json; charset=UTF-8',
        //   // },
        // ),
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
    final temp = query.toLowerCase();
    try {
      final response =
          await _restClient.get("/datauser", queryParameters: {key: query});

      if (response is List<dynamic>) {
        final data = response;

        final List<UserModel> searchData = data.map((e) {
          return UserModel.fromMap(e);
        }).toList();

        final List<UserModel> filterData = searchData.where((e) {
          return e.id.toLowerCase().contains(temp) ||
              e.name!.toLowerCase().contains(temp) ||
              e.address!.toLowerCase().contains(temp) ||
              e.mail!.toLowerCase().contains(temp) ||
              e.nationality!.toLowerCase().contains(temp);
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
        "/datauser/$id",
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
