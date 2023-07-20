import 'package:budget_buddy/common_widgets/controllers/navigation_profile_controller.dart';
import 'package:budget_buddy/features/authentication/screens/splash_screen/splash_screen.dart';
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
  final isLoggedIn = RxBool(false);

  Future<bool> loginUser(String email, String password) async {
    var result = await AuthenticationRepository().loginUser(email, password);
    if (result == "error") {
      Get.snackbar("Error", "You provided wrong data");
      return false;
    } else {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(result);
      String tokenValue = decodedToken.values.elementAt(0).toString();
      await storage.write(key: 'token', value: tokenValue);
      isLoggedIn.value = true;
      return true;
    }
  }

  void logout() async {
    await storage.delete(key: 'token');
    isLoggedIn.value = false;
    Get.delete<NavigationProfileController>();
    Get.offAll(() => const SplashScreen());
  }
}
