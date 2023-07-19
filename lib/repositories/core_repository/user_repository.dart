import 'dart:convert';

import 'package:dio/dio.dart';

import '../../auth/secrets.dart';
import '../../features/core/models/user_model.dart';

class UserRepository {
  final Dio _dio = Dio();

  Future<UserModel> getUser(String userId) async {
    try {
      var response = await _dio.get('$apiAdress/Users', queryParameters: {
        "id": userId,
      });
      if (response.statusCode == 200) {
        var user = userModelFromJson(json.encode(response.data));
        return user;
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      throw e.response!.data;
    }
  }
}
