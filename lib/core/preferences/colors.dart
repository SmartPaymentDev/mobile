import 'package:flutter/material.dart';

class PreferenceColors {
  PreferenceColors._();

  static const MaterialColor purple = MaterialColor(
    0xff5C2684, // Base color
    <int, Color>{
      50: Color(0xffE9E0F2),
      100: Color(0xffD2BEE5),
      200: Color(0xffB890D8),
      300: Color(0xff9D62CB),
      400: Color(0xff8144A9),
      500: Color(0xff5C2684),
      600: Color(0xff501E75),
      700: Color(0xff411662),
      800: Color(0xff320E4F),
      900: Color(0xff23043B),
    },
  );

  static const MaterialColor yellow = MaterialColor(
    0xffF5BE0C, // Base color
    <int, Color>{
      50: Color(0xffFEF4DC), // Lightest shade
      100: Color(0xffFDE8B0),
      200: Color(0xffFCD87F),
      300: Color(0xffFBC74E),
      400: Color(0xffF9B727),
      500: Color(0xffF5BE0C), // Base color
      600: Color(0xffD9A50A),
      700: Color(0xffB98A09),
      800: Color(0xff9A7007),
      900: Color(0xff6F4E05), // Darkest shade
    },
  );

  static const MaterialColor red = MaterialColor(
    0xffD32F2F, // Base color
    <int, Color>{
      50: Color(0xffFDE0E0), // Lightest shade
      100: Color(0xffF9B3B3),
      200: Color(0xffF48383),
      300: Color(0xffEF5252),
      400: Color(0xffEB3232),
      500: Color(0xffD32F2F), // Base color
      600: Color(0xffBA2A2A),
      700: Color(0xffA22525),
      800: Color(0xff891F1F),
      900: Color(0xff5E1515), // Darkest shade
    },
  );

  static const MaterialColor green = MaterialColor(
    0xff388E3C, // Base color
    <int, Color>{
      50: Color(0xffE0F2E3), // Lightest shade
      100: Color(0xffB3DEC0),
      200: Color(0xff80C899),
      300: Color(0xff4DB271),
      400: Color(0xff269F53),
      500: Color(0xff388E3C), // Base color
      600: Color(0xff327E36),
      700: Color(0xff2B6B2E),
      800: Color(0xff245827),
      900: Color(0xff183D1A), // Darkest shade
    },
  );

  static const MaterialColor white = MaterialColor(
    0xffFFFFFF,
    <int, Color>{
      50: Color(0xfffdfdfd),
      100: Color(0xfffbfbfb),
      200: Color(0xfff9f9f9),
      300: Color(0xfff7f7f7),
      400: Color(0xfff5f5f5),
      500: Color(0xffFFFFFF),
      600: Color(0xffe4e4e4),
      700: Color(0xffcbcbcb),
      800: Color(0xffb2b2b2),
      900: Color(0xff8a8a8a),
    },
  );

  static const MaterialColor black = MaterialColor(
    0xff212121, // Base color
    <int, Color>{
      50: Color(0xffF5F5F5), // Lightest shade (soft gray)
      100: Color(0xffE0E0E0),
      200: Color(0xffBDBDBD),
      300: Color(0xff9E9E9E),
      400: Color(0xff757575),
      500: Color(0xff616161),
      600: Color(0xff424242),
      700: Color(0xff303030),
      800: Color(0xff212121), // Base color
      900: Color(0xff121212), // Darkest shade (near black)
    },
  );
}
