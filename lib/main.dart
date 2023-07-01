import 'package:budget_buddy/utilities/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/authentication/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.defaultTheme,
      // theme: ThemeData(fontFamily: GoogleFonts.roboto().fontFamily),
      title: 'budgetBuddy',
      home: const SplashScreen(),
    );
  }
}
