import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'CabinetGrotesk',
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.black87,
        surfaceTintColor: Colors.green.shade400,
        elevation: 2.0,
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30.0,
          weight: 900.0,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade100),
      useMaterial3: true,
    );
  }

}