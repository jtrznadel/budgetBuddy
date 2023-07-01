import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSplashWidget extends StatelessWidget {
  const BottomSplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Your Budget\'s Best Buddy!',
            style: TextStyle(
                fontSize: 27.0, fontWeight: FontWeight.bold, color: kSecondaryColor),
          ),
          const SizedBox(height: 30.0),
          Text(
            'Master your money and achieve financial freedom effortlessly. '
            'Track, plan, and conquer your financial goals with ease.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0,
              color: kSecondaryColor.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 50.0),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () => Get.to(() => const WelcomeScreen()),
              child: Container(
                height: 85.0,
                width: 85.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kSecondaryColor, width: 2.0),
                ),
                child:
                    const Icon(Icons.chevron_right, size: 50.0, color: kSecondaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
