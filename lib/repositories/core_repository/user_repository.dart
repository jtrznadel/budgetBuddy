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
        var jsonData = response.data as List<dynamic>;

        if (jsonData.isNotEmpty) {
          // Assuming the first element in the list is the user object
          var user = UserModel.fromJson(jsonData[0]);
          return user;
        } else {
          // Handle the case when the list is empty (user not found)
          throw Exception("User not found");
        }
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
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
      return response.data.statusCode;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.statusCode ?? 500;
      } else {
        return 500;
      }
    }
  }
}
