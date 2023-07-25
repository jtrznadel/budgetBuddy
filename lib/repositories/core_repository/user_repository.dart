import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../auth/secrets.dart';
import '../../features/core/models/user_model.dart';

class UserRepository {
  final Dio _dio = Dio();

  Future<UserModel> getUser(String userId) async {
    try {
      var response = await _dio.get('$apiAdress/Users/$userId', queryParameters: {
        "id": userId,
      });
      if (response.statusCode == 200) {
        var jsonData = response.data as Map<String, dynamic>;

        var user = UserModel.fromJson(jsonData);
        return user;
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      Get.snackbar("Error", "Something went wrong!");
      throw e.response!.data;
    }
  }

  Future<int> updateUserData(UserModel user) async {
    try {
      var response = await _dio.put('$apiAdress/Users/${user.userId}', data: {
        "userId": '${user.userId}',
        "email": user.email,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "role": user.role,
      });
      return response.statusCode!;
    } on DioException catch (e) {
      Get.snackbar("Error", "Something went wrong!");
      if (e.response != null) {
        return e.response!.statusCode ?? 500;
      } else {
        return 500;
      }
    }
  }
}
