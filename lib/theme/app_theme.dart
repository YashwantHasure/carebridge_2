import 'package:flutter/material.dart';

class AppTheme {
  // =========================================================
  // CAREBRIDGE COLOR PALETTE
  // =========================================================

  static const Color primary = Color(0xFF18A7A0);
  static const Color primaryDark = Color(0xFF087D7A);

  static const Color navy = Color(0xFF183B56);
  static const Color navyLight = Color(0xFF315C72);

  static const Color background = Color(0xFFF7FAFC);
  static const Color card = Colors.white;

  static const Color textPrimary = Color(0xFF172B3A);
  static const Color textSecondary = Color(0xFF65758B);

  static const Color green = Color(0xFF32A66A);
  static const Color orange = Color(0xFFF28C28);
  static const Color purple = Color(0xFF7B3FC6);
  static const Color blue = Color(0xFF2878D4);

  // =========================================================
  // LIGHT THEME
  // =========================================================

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: primary,
      secondary: navy,
      surface: card,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: textPrimary,
      elevation: 0,
    ),

    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        color: textPrimary,
        letterSpacing: -0.7,
      ),

      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: textPrimary,
      ),

      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),

      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        color: textPrimary,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondary,
        height: 1.35,
      ),

      bodySmall: TextStyle(
        fontSize: 12,
        color: textSecondary,
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      height: 72,
      elevation: 4,

      indicatorColor: const Color(0x2218A7A0),

      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),

      iconTheme: WidgetStateProperty.resolveWith(
            (states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: primary,
              size: 25,
            );
          }

          return const IconThemeData(
            color: textSecondary,
            size: 23,
          );
        },
      ),
    ),
  );
}