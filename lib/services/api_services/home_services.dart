import 'package:dio/dio.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/services/repository/home_repository.dart';

class HomeServices extends HomeRepository {
  @override
  Future<UserModel> createData(UserModel newUser) async {
    try {
      final response = await Dio().post(
          ("https://66879c080bc7155dc0185037.mockapi.io/datauser"),
          data: newUser.toMap());

      if (response.statusCode == 201) {
        return UserModel.fromMap((response.data));
      } else {
        throw Exception('Fail to create data');
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<UserModel>> getData() async {
    try {
      final response = await Dio()
          .get(('https://66879c080bc7155dc0185037.mockapi.io/datauser'));

      final users = response.data as List<dynamic>;

      final List<UserModel> loadData = users.map((e) {
        return UserModel.fromMap(e);
      }).toList();

      return loadData;
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<bool> deleteData(String id) async {
    try {
      final response = await Dio().delete(
        ('https://66879c080bc7155dc0185037.mockapi.io/datauser/$id'),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<UserModel>> searchData(String key, String query) async {
    final tmp = query.toLowerCase();
    try {
      final response = await Dio().get(
          'https://66879c080bc7155dc0185037.mockapi.io/datauser/?$key=$query');
      if (response.statusCode == 200) {
        final users = response.data as List<dynamic>;
        final List<UserModel> searchData = users.map((e) {
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
      final response = await Dio().put(
        ("https://66879c080bc7155dc0185037.mockapi.io/datauser/$id"),
        data: (newUser.toMap()),
      );

      if (response.statusCode == 200) {
        return UserModel.fromMap((response.data));
      } else {
        throw Exception('Fail to update data');
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
