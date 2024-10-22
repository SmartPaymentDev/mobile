import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/preferences/preferences.dart';

class ThemeLight {
  ThemeLight(this.primaryColor);

  final Color primaryColor;

  final Color errorColor = PreferenceColors.red;
  final Color scaffoldColor = PreferenceColors.white;
  final Color textSolidColor = PreferenceColors.black;
  final Color textSecondaryColor = PreferenceColors.white[500]!;

  final String fontFamily = 'Poppins';

  ColorScheme get colorScheme => ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        error: errorColor,
      );

  ThemeData get theme => ThemeData(
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: PreferenceColors.white);
}
