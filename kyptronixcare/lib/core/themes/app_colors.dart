// app_colors.dart

import 'package:flutter/material.dart';

// Define light theme colors
class LightColors {
  static Color primary = Colors.yellow.shade800;
  static Color secondary = Colors.blue.shade900;
  static const Color error = Color(0xFFB00020);
  static const Color textColor = Colors.black;
  static const Color onSurface = Color.fromARGB(255, 40, 39, 39);

  static const Color scaffoldBackground = Color(0xFFF3F3F8);
  static const Color cardBackground = Color(0xFFE0E0E6);
  static const Color drawerBackground = Color(0xFFF3F3F8);

  /* ---------------------------------- ---- ---------------------------------- */
  static const Color surface = Color(0xDE000000);
  static const Color surfaceContainer = Colors.white;
  static Color onSecondaryContainer = Colors.grey.shade300;
  static const Color onSecondary = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);
}

// Define dark theme colors
class DarkColors {
  static Color primary = Colors.yellow.shade800;
  static Color secondary = Colors.blue.shade900;
  static const Color error = Color(0xFFB00020);
  static const Color textColor = Colors.white;
  static const Color onSurface = Color(0xFFE0E0E0);

  static const Color scaffoldBackground = Color(0xFF1F1D2B);
  static const Color cardBackground = Color(0xFF2A293B);
  static const Color drawerBackground = Color(0xFF1F1D2B);

  /* ---------------------------------- ---- ---------------------------------- */
  static const Color surfaceContainer = Color(0xFF262626);
  static Color onSecondaryContainer = Colors.grey.shade300;
  static const Color onPrimary = Color(0xFF000000);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onError = Color(0xFF000000);
}

class GradientColors {
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFCC50B), Color(0xFFF8B400)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Gradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF38946D), Color(0xFF006C3E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
