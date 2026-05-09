import 'package:flutter/material.dart';

import 'theme_preset.dart';

class AppTheme {
  static ThemeData light([AppThemePreset preset = AppThemePreset.abasto]) =>
      _buildLight(preset);

  static ThemeData dark([AppThemePreset preset = AppThemePreset.abasto]) =>
      _buildDark(preset);

  static ThemeData _buildLight(AppThemePreset preset) {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: preset.seedColor,
          brightness: Brightness.light,
          surface: preset.lightSurfaceColor,
          surfaceContainerHighest: preset.lightSurfaceContainerHighest,
          primaryContainer: Color.alphaBlend(
            preset.seedColor.withValues(alpha: 0.16),
            preset.lightSurfaceColor,
          ),
        ).copyWith(
          secondary: preset.accentColor,
          tertiary: preset.decorativeWoodColor,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: preset.lightScaffoldColor,
      extensions: [
        AppThemeDecoration(
          preset: preset,
          accentColor: preset.accentColor,
          woodColor: preset.decorativeWoodColor,
        ),
      ],
      cardTheme: CardThemeData(
        color: preset.lightSurfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: preset.lightBorderColor),
        ),
        shadowColor: Colors.black.withValues(alpha: 0.08),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: preset.lightSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: preset.lightBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: preset.lightBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: preset.seedColor, width: 1.4),
        ),
      ),
    );
  }

  static ThemeData _buildDark(AppThemePreset preset) {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: preset.seedColor,
          brightness: Brightness.dark,
          surface: preset.darkSurfaceColor,
          surfaceContainerHighest: preset.darkSurfaceContainerHighest,
          primaryContainer: Color.alphaBlend(
            preset.seedColor.withValues(alpha: 0.24),
            preset.darkScaffoldColor,
          ),
        ).copyWith(
          secondary: preset.accentColor,
          tertiary: preset.decorativeWoodColor,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: preset.darkScaffoldColor,
      extensions: [
        AppThemeDecoration(
          preset: preset,
          accentColor: preset.accentColor,
          woodColor: preset.decorativeWoodColor,
        ),
      ],
      cardTheme: CardThemeData(
        color: preset.darkSurfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: preset.darkBorderColor),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: preset.darkSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: preset.darkBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: preset.darkBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: preset.seedColor, width: 1.4),
        ),
      ),
    );
  }
}
