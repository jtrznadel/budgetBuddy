import 'package:budget_buddy/utilities/widget_themes/elevated_button_theme.dart';
import 'package:budget_buddy/utilities/widget_themes/outlined_button_theme.dart';
import 'package:budget_buddy/utilities/widget_themes/text_field_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData defaultTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: GoogleFonts.roboto().fontFamily,
      inputDecorationTheme: TTextFormFieldTheme.defaultInputDecorationTheme,
      elevatedButtonTheme: TElevatedButtonTheme.defaultElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.defaultOutlinedButtonTheme);
}
