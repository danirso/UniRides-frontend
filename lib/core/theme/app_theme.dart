import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores extraídas da logo
  static const Color primaryTeal = Color(0xFF27187E); // Verde-azulado dos prédios e carro
  static const Color darkBackground = Color(0xFF1B2A4A); // Azul escuro da base/sombras
  static const Color sandYellow = Color(0xFF4CC9F0); // Areia/Amarelo do céu
  static const Color lightMint = Color(0xFFB8C0FF); // Verde claro dos reflexos
  static const Color dangerRed = Color(0xFFD32F2F);

  static ThemeData get lightTheme {
    return ThemeData(
      textTheme: GoogleFonts.montserratTextTheme(),
      scaffoldBackgroundColor: const Color(0xFFF7F7FF),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryTeal,
        primary: primaryTeal,
        secondary: sandYellow,
        surface: Color(0xFFE6E6F2),
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
        navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFE6E6F2),
        indicatorColor: primaryTeal.withOpacity(0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(color: primaryTeal, fontWeight: FontWeight.bold);
          }
          return TextStyle(color: Colors.grey.shade600);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: primaryTeal);
          }
          return IconThemeData(color: Colors.grey.shade600);
        }),
      ),
        tabBarTheme: const TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: primaryTeal,
      ),
    );
  }
}