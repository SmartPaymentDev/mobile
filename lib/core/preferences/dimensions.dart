import 'package:flutter/material.dart';

class Dimensions {
  Dimensions._();

  static double containerHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.965;
  }

  static double containerTopMargin(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.035;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static const double dp2 = 2.0;
  static const double dp4 = 4.0;
  static const double dp6 = 6.0;
  static const double dp8 = 8.0;
  static const double dp10 = 10.0;
  static const double dp12 = 12.0;
  static const double dp14 = 14.0;
  static const double dp16 = 16.0;
  static const double dp18 = 18.0;
  static const double dp20 = 20.0;
  static const double dp22 = 22.0;
  static const double dp24 = 24.0;
  static const double dp26 = 26.0;
  static const double dp32 = 32.0;
  static const double dp38 = 38.0;
  static const double dp48 = 48.0;
}