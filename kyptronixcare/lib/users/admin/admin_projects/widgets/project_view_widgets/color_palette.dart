import 'package:flutter/material.dart';

class ColorPalette {
  // Light Theme Colors
  static const lightPrimaryGradientStart = Color(0xFF4158D0);
  static const lightPrimaryGradientMiddle = Color(0xFFC850C0);
  static const lightPrimaryGradientEnd = Color(0xFFFFCC70);
  static const lightAccent1 = Color(0xFF00B4DB);
  static const lightAccent2 = Color(0xFF0083B0);
  static const lightAccent3 = Color(0xFFFF6B6B);
  static const lightSuccess = Color(0xFF48C9B0);
  static const lightWarning = Color(0xFFF4D03F);
  static const lightError = Color(0xFFE74C3C);
  static const lightCardBg1 = Color(0xFFF8F9FE);
  static const lightCardBg2 = Color(0xFFF2F5FF);
  static const lightTextPrimary = Color(0xFF000000);

  // Dark Theme Colors
  static const darkPrimaryGradientStart = Color(0xFF2A3157);
  static const darkPrimaryGradientMiddle = Color(0xFF9B3B9B);
  static const darkPrimaryGradientEnd = Color(0xFFCC9E50);
  static const darkAccent1 = Color(0xFF0090B0);
  static const darkAccent2 = Color(0xFF006A8F);
  static const darkAccent3 = Color(0xFFFF4F4F);
  static const darkSuccess = Color(0xFF2EAF94);
  static const darkWarning = Color(0xFFD4B32F);
  static const darkError = Color(0xFFCF3C2D);
  static const darkCardBg1 = Color(0xFF1E1E2E);
  static const darkCardBg2 = Color(0xFF2A2A3A);
  static const darkTextPrimary = Color(0xFFFFFFFF);

  static Color getCardBg1(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? lightCardBg1
        : const Color.fromARGB(255, 17, 17, 29);
  }

  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? lightTextPrimary
        : darkTextPrimary;
  }
}
