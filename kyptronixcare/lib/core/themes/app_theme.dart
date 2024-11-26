// app_theme.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: LightColors.primary,
      secondary: LightColors.secondary,
      surface: Colors.white,
      onSurface: LightColors.onSurface,
      error: LightColors.error,
      brightness: Brightness.light,
    ),

    // dividerTheme: DividerThemeData(color: ),
    scaffoldBackgroundColor: LightColors.scaffoldBackground,
    cardTheme: const CardTheme(color: LightColors.cardBackground),
    drawerTheme: const DrawerThemeData(
      backgroundColor: LightColors.drawerBackground,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTextStyles.lightTextTheme.bodyLarge,
      ),
    ),
    textTheme: AppTextStyles.lightTextTheme,
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.amber,
      cursorColor: Colors.black,
      selectionHandleColor: Colors.amber,
    ),

    brightness: Brightness.light,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: DarkColors.primary,
      secondary: DarkColors.secondary,
      surface: Colors.black,
      onSurface: DarkColors.onSurface,
      error: DarkColors.error,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: DarkColors.scaffoldBackground,
    cardTheme: const CardTheme(color: DarkColors.cardBackground),
    drawerTheme: const DrawerThemeData(
      backgroundColor: DarkColors.drawerBackground,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTextStyles.darkTextTheme.displayLarge,
      ),
    ),
    textTheme: AppTextStyles.darkTextTheme,
    primaryColor: Colors.white,
  );
}
