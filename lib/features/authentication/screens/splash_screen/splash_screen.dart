import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:budget_buddy/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'widgets/bottom_splash_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _splashController;
  bool isAnimationFinished = false;
  bool displaySplashText = false;

  @override
  void initState() {
    super.initState();
    _splashController = AnimationController(vsync: this);
    _splashController.addListener(() {
      if (_splashController.value >= 0.9) {
        isAnimationFinished = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          displaySplashText = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    _splashController.dispose(); // Dispose the animation controller properly
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: isAnimationFinished ? size.height / 1.8 : size.height,
            decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(isAnimationFinished ? 40 : 0),
                    bottomRight: Radius.circular(isAnimationFinished ? 40 : 0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/splashAnimationFinal.json',
                    controller: _splashController,
                    onLoaded: (composition) {
                      _splashController
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText('.budgetBuddy',
                          textStyle: const TextStyle(fontSize: 36, color: kPrimaryColor),
                          speed: const Duration(milliseconds: 200))
                    ],
                  )),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isAnimationFinished,
            child: AnimatedOpacity(
                opacity: displaySplashText ? 1 : 0,
                duration: const Duration(seconds: 2),
                child: const BottomSplashWidget()),
          ),
        ],
      ),
    );
  }
}
