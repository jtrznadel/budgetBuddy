import 'package:budget_buddy/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();
  final storage = const FlutterSecureStorage();

  bool isPasswordObscured = true;

  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser(String email, String password) async {
    var result = await AuthenticationRepository().loginUser(email, password);
    //getUserData(result.toString());
  }

  void getUserData(String token) async {
    await storage.write(key: 'token', value: token.toString());
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print(decodedToken);
  }
}
