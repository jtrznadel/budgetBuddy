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
}
