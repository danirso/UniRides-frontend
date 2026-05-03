import 'package:flutter/material.dart';

class AppTheme {
  // Cores extraídas da logo
  static const Color primaryTeal = Color(0xFF679E96); // Verde-azulado dos prédios e carro
  static const Color darkBackground = Color(0xFF10161C); // Azul escuro da base/sombras
  static const Color sandYellow = Color(0xFFE3C598); // Areia/Amarelo do céu
  static const Color lightMint = Color(0xFFC7E0D8); // Verde claro dos reflexos

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF5F7F6),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryTeal,
        primary: primaryTeal,
        secondary: sandYellow,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: darkBackground,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryTeal,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryTeal),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryTeal, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}