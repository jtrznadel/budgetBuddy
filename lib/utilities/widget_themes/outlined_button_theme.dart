import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:flutter/material.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final defaultOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          foregroundColor: kPrimaryColor,
          side: const BorderSide(color: kPrimaryColor),
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2)));
}
