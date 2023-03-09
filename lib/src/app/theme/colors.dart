import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColorBackground = Color(0xff2d120c);
  static const Color accentColor = Color(0xFFFC8267);
  static const Color secondaryColor = Color(0xFFFC8267);
  static const Color red = Color(0xFFFF1F1F);
  static const Color green = Color(0xFF1FFF1F);
  static const Color white = Colors.white;
  static Color white40 = Colors.white.withOpacity(0.4);
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color transparent = Colors.transparent;

  static const MaterialColor primaryColor =
      MaterialColor(0xFFFC8267, <int, Color>{
    50: Color(0xfffff3f0),
    100: Color(0xffffdbd1),
    200: Color(0xffffb6a4),
    300: Color(0xffff9d86),
    400: Color(0xfffe8f77),
    500: Color(0xfffc8267),
    600: Color(0xffbb5f4b),
    700: Color(0xff7e3e30),
    800: Color(0xff2d120c),
    900: Color(0xff030100),
  });
}
