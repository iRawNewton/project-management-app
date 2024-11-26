import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define text styles
class AppTextStyles {
  // Light theme

  static final TextTheme lightTextTheme = TextTheme(
    // headline_1
    titleLarge: GoogleFonts.prompt(
      color: const Color(0xFF151419),
    ),

    // bodyText1
    bodyLarge: GoogleFonts.outfit(
      color: const Color(0xFF151419),
    ),

    // numbers
    displayLarge: GoogleFonts.spaceGrotesk(
      color: const Color(0xFF151419),
    ),
  );

  // Dark theme
  static final TextTheme darkTextTheme = TextTheme(
    // headline_1
    titleLarge: GoogleFonts.prompt(
      color: const Color(0xFFFBFBFB),
    ),

    // bodyText1
    bodyLarge: GoogleFonts.jost(
      color: const Color(0xFFFBFBFB),
    ),

    // numbers
    displayLarge: GoogleFonts.spaceGrotesk(
      color: const Color(0xFFFBFBFB),
    ),
  );
}
