import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final defaultElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          foregroundColor: kSecondaryColor,
          backgroundColor: kPrimaryColor,
          side: const BorderSide(color: kPrimaryColor),
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2)));
}
