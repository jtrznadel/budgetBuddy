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
      title: 'budgetBuddy',
      home: const SplashScreen(),
    );
  }
}


// await Firebase.initializeApp(
//       options: const FirebaseOptions(
//           apiKey: "AIzaSyD6b_Nj4SBty0ZP6MIv5cji1HJgGciHYy0",
//           authDomain: "budgetbuddy-5ff9e.firebaseapp.com",
//           projectId: "budgetbuddy-5ff9e",
//           storageBucket: "budgetbuddy-5ff9e.appspot.com",
//           messagingSenderId: "1069268818717",
//           appId: "1:1069268818717:web:ce40f90877a3532ef9dff4"));