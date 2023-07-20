import 'package:budget_buddy/common_widgets/navigation/navigation_profile_widget.dart';
import 'package:budget_buddy/features/authentication/controllers/login_controller.dart';
import 'package:budget_buddy/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final LogInController _logInController = Get.put(LogInController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (_logInController.isLoggedIn.value) {
            return NavigationProfile(); // Show the main app content
          } else {
            return const SplashScreen(); // Show the login screen
          }
        },
      ),
    );
  }
}
