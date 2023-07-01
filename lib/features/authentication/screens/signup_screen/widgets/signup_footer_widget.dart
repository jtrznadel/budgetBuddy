import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/authentication/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
          onPressed: () => Get.to(() => const LoginScreen()),
          child: const Text.rich(TextSpan(
              text: "Already have an Account? ",
              style: TextStyle(fontSize: 14, color: Colors.black),
              children: [
                TextSpan(
                    text: "Login now",
                    style: TextStyle(fontSize: 16, color: kPrimaryColor))
              ]))),
    );
  }
}
