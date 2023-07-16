import 'package:budget_buddy/features/authentication/screens/login_screen/login_screen.dart';
import 'package:budget_buddy/features/core/controllers/categories_controller.dart';
import 'package:budget_buddy/features/core/controllers/expenses_controller.dart';
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

  Future<bool> loginUser(String email, String password) async {
    var result = await AuthenticationRepository().loginUser(email, password);
    if (result == "error") {
      Get.snackbar("Error", "You provided wrong data");
      return false;
    } else {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(result);
      String tokenValue = decodedToken.values.elementAt(0).toString();
      await storage.write(key: 'token', value: tokenValue);
      return true;
    }
  }

  void logout() async {
    await storage.delete(key: 'token');
    Get.find<CategoriesController>().dispose();
    Get.find<ExpensesController>().dispose();
    Get.offAll(() => const LoginScreen());
  }
}
