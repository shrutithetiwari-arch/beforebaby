import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xFF6366F1);
  static const secondaryColor = Color(0xFF8B5CF6);
  static const accentColor = Color(0xFFEC4899);
  
  static const backgroundColor = Color(0xFFFAFAFA);
  static const surfaceColor = Color(0xFFFFFFFF);
  static const errorColor = Color(0xFFEF4444);
  static const successColor = Color(0xFF10B981);
  static const warningColor = Color(0xFFF59E0B);
  
  static const darkBackgroundColor = Color(0xFF0F172A);
  static const darkSurfaceColor = Color(0xFF1E293B);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        labelStyle: const TextStyle(color: Color(0xFF64748B)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0F172A),
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0F172A),
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0F172A),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Color(0xFF1E293B),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color(0xFF475569),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurfaceColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Color(0xFFF8FAFC),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E293B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
      ),
    );
  }
}
