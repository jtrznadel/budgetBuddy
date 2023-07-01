import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/authentication/screens/login_screen/login_screen.dart';
import 'package:budget_buddy/features/authentication/screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/welcomeScreenImage.svg'),
            Center(
                child: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TyperAnimatedText('.budgetBuddy',
                    textStyle: const TextStyle(fontSize: 36, color: kPrimaryColor),
                    speed: const Duration(milliseconds: 200))
              ],
            )),
            SizedBox(
              height: size.height * 0.1,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5.0), boxShadow: [
                    BoxShadow(
                        color: kPrimaryColor.withOpacity(0.4),
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: const Offset(0, 3))
                  ]),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                      onPressed: () => Get.to(() => const LoginScreen()),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 16),
                      )),
                )),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5.0), boxShadow: [
                    BoxShadow(
                        color: kPrimaryColor.withOpacity(0.4),
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: const Offset(0, 3))
                  ]),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                      onPressed: () => Get.to(() => const SignUpScreen()),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 16),
                      )),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
