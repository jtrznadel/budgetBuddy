import 'package:budget_buddy/auth/secrets.dart';
import 'package:budget_buddy/features/authentication/screens/login_screen/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as gett;

class AuthenticationRepository {
  final Dio _dio = Dio();

  Future<Response> registerUser(Map<String, dynamic> userData) async {
    try {
      Response response = await _dio.post('$apiAdress/Users/Register', data: userData);
      gett.Get.to(() => const LoginScreen());
      return response.data;
    } on DioException catch (e) {
      gett.Get.snackbar("Error", "Please provide proper data");
      return e.response!.data;
    }
  }

  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        '$apiAdress/Users/Login',
        data: {'email': email, 'password': password},
      );
      return response.toString();
    } on DioException {
      return "error";
    }
  }

  Future<Response> getUserData(int id) async {
    try {
      Response response = await _dio.post(
        '$apiAdress/Users/Login',
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
