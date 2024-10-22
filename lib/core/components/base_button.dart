import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/preferences/colors.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final bool isLoading;

  const BaseButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.backgroundColor = PreferenceColors.purple,
    this.textColor = PreferenceColors.white,
    this.borderColor = PreferenceColors.purple,
    this.isLoading = false,
  });

  factory BaseButton.primary({
    required String text,
    required VoidCallback onPressed,
    double? width,
    bool isLoading = false,
  }) =>
      BaseButton(
        text: text,
        onPressed: onPressed,
        width: width,
        backgroundColor: PreferenceColors.purple,
        textColor: Colors.white,
        borderColor: PreferenceColors.purple,
        isLoading: isLoading,
      );

  factory BaseButton.secondary({
    required String text,
    required VoidCallback onPressed,
    double? width,
    bool isLoading = false,
  }) =>
      BaseButton(
        text: text,
        onPressed: onPressed,
        width: width,
        backgroundColor: const Color(0xFFF2F3F2),
        textColor: PreferenceColors.purple,
        borderColor: Colors.white,
        isLoading: isLoading,
      );

  factory BaseButton.outlined({
    required String text,
    required VoidCallback onPressed,
    double? width,
    bool isLoading = false,
  }) =>
      BaseButton(
        text: text,
        onPressed: onPressed,
        width: width,
        backgroundColor: Colors.transparent,
        textColor: PreferenceColors.purple,
        borderColor: PreferenceColors.purple,
        isLoading: isLoading,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  strokeWidth: 2.0,
                ),
              )
            : Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}