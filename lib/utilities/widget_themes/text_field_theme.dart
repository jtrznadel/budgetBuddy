import 'package:budget_buddy/constants/color_palette.dart';
import 'package:flutter/material.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme defaultInputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      prefixIconColor: kPrimaryColor,
      floatingLabelStyle: const TextStyle(color: Colors.black),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0, color: Colors.black),
          borderRadius: BorderRadius.circular(100)));
}
