import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF6C63FF),
    secondary: const Color(0xFF8B85FF),
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    surfaceTint: const Color(0xFF6C63FF).withValues(alpha: 0.1),
    shadow: Colors.black.withValues(alpha: 0.1),
    inversePrimary: Colors.black,
    surfaceDim:  const Color(0xFFF7F7F7),
    surfaceContainer: Colors.white,
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFF6C63FF),
    secondary: const Color(0xFF8B85FF),
    surface: const Color(0xFF121212),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    surfaceTint: const Color(0xFF6C63FF).withValues(alpha: 0.1),
    shadow: Colors.black.withValues(alpha: 0.3),
    inversePrimary: Colors.white,
    surfaceDim: Colors.grey.shade900,
    surfaceContainer: const Color.fromARGB(255, 48, 45, 45),
  ),
);
