import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: const Color(0xFF3D5AFE),
    scaffoldBackgroundColor: const Color(0xFFF7F8FA),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: const Color(0xFF3D5AFE),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
