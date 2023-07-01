import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/authentication/screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
          onPressed: () => Get.to(() => const SignUpScreen()),
          child: const Text.rich(TextSpan(
              text: "Don't have an Account? ",
              style: TextStyle(fontSize: 14, color: Colors.black),
              children: [
                TextSpan(
                    text: "Sign Up now",
                    style: TextStyle(fontSize: 16, color: kPrimaryColor))
              ]))),
    );
  }
}
