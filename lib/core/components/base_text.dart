// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/preferences/preferences.dart';

class BaseText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color; // Mengubah tipe data menjadi Color nullable
  final TextAlign textAlign;
  final FontWeight fontWeight;

  static const Color defaultColor = PreferenceColors.black; // Menggunakan warna default dari PreferenceColors
  static const TextAlign defaultTextAlign = TextAlign.start;
  static const FontWeight defaultFontWeight = FontWeight.w400;

  const BaseText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color, // Mengubah tipe data menjadi nullable
    this.textAlign = defaultTextAlign,
    this.fontWeight = defaultFontWeight,
  });

  factory BaseText.XXL(
    String text, {
    Color? color, // Mengubah tipe data menjadi nullable
    TextAlign textAlign = defaultTextAlign,
    FontWeight fontWeight = defaultFontWeight,
  }) {
    return BaseText(
      text: text,
      fontSize: 28.0,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
    );
  }

  factory BaseText.XL(
    String text, {
    Color? color, // Mengubah tipe data menjadi nullable
    TextAlign textAlign = defaultTextAlign,
    FontWeight fontWeight = defaultFontWeight,
  }) {
    return BaseText(
      text: text,
      fontSize: 24.0,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
    );
  }

  factory BaseText.L(
    String text, {
    Color? color, // Mengubah tipe data menjadi nullable
    TextAlign textAlign = defaultTextAlign,
    FontWeight fontWeight = defaultFontWeight,
  }) {
    return BaseText(
      text: text,
      fontSize: 20.0,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
    );
  }

  factory BaseText.M(
    String text, {
    Color? color, // Mengubah tipe data menjadi nullable
    TextAlign textAlign = defaultTextAlign,
    FontWeight fontWeight = defaultFontWeight,
  }) {
    return BaseText(
      text: text,
      fontSize: 16.0,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
    );
  }

  factory BaseText.S(
    String text, {
    Color? color, // Mengubah tipe data menjadi nullable
    TextAlign textAlign = defaultTextAlign,
    FontWeight fontWeight = defaultFontWeight,
  }) {
    return BaseText(
      text: text,
      fontSize: 14.0,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
    );
  }

  factory BaseText.XS(
    String text, {
    Color? color, // Mengubah tipe data menjadi nullable
    TextAlign textAlign = defaultTextAlign,
    FontWeight fontWeight = defaultFontWeight,
  }) {
    return BaseText(
      text: text,
      fontSize: 12.0,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? defaultColor, // Menggunakan color yang disediakan atau default jika tidak tersedia
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}