import 'package:flutter/material.dart';

Color primary = const Color(0xFFF04147);
Color secondary = const Color(0xFF3E3E3E);

Color textPrimary = const Color(0xFF000000);
Color textSecondary = const Color(0xFF969696);
Color textTeritary = const Color(0xFFDEDEDE);
Color textLink = const Color(0xFF5323C9);
Color textPlaceholder = const Color(0xFFB1B1B1);

ThemeData lightTheme = ThemeData(
  primaryColor: primary,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    secondary: secondary,
    primary: Colors.black,
    outline: Colors.grey.shade300,
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: primary,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade900,
    secondary: secondary,
    primary: Colors.white,
    outline: Colors.grey.shade300,
  ),
);
