import 'package:flutter/material.dart';

enum AppThemePreset {
  abasto(
    id: 'abasto',
    label: 'Abasto',
    description: 'Verde claro',
    seedColor: Color(0xFF4CAF50),
    accentColor: Color(0xFFFF8A3D),
  ),
  feria(
    id: 'feria',
    label: 'Feria',
    description: 'Verde hoja',
    seedColor: Color(0xFF2E7D32),
    accentColor: Color(0xFFFFB74D),
  ),
  supermercado(
    id: 'supermercado',
    label: 'Supermercado',
    description: 'Azul limpio',
    seedColor: Color(0xFF2563EB),
    accentColor: Color(0xFF22C55E),
  ),
  neutral(
    id: 'neutral',
    label: 'Neutral',
    description: 'Gris suave',
    seedColor: Color(0xFF64748B),
    accentColor: Color(0xFF10B981),
  ),
  hawaii(
    id: 'hawaii',
    label: 'Hawaii',
    description: 'Laguna y coral',
    seedColor: Color(0xFF008C8C),
    accentColor: Color(0xFFE8753B),
  );

  const AppThemePreset({
    required this.id,
    required this.label,
    required this.description,
    required this.seedColor,
    required this.accentColor,
  });

  final String id;
  final String label;
  final String description;
  final Color seedColor;
  final Color accentColor;

  Color get lightScaffoldColor {
    return switch (this) {
      AppThemePreset.hawaii => const Color(0xFFFFF5E7),
      _ => const Color(0xFFF7FAF7),
    };
  }

  Color get darkScaffoldColor {
    return switch (this) {
      AppThemePreset.hawaii => const Color(0xFF102420),
      _ => const Color(0xFF101512),
    };
  }

  Color get lightSurfaceColor {
    return switch (this) {
      AppThemePreset.hawaii => const Color(0xFFFFFBF4),
      _ => Colors.white,
    };
  }

  Color get darkSurfaceColor {
    return switch (this) {
      AppThemePreset.hawaii => const Color(0xFF17302B),
      _ => const Color(0xFF17211A),
    };
  }

  Color get lightSurfaceContainerHighest {
    return switch (this) {
      AppThemePreset.hawaii => const Color(0xFFF6E4CA),
      _ => const Color(0xFFEFF5EF),
    };
  }

  Color get darkSurfaceContainerHighest {
    return switch (this) {
      AppThemePreset.hawaii => const Color(0xFF26433D),
      _ => const Color(0xFF223126),
    };
  }

  Color get lightBorderColor {
    return switch (this) {
      AppThemePreset.hawaii => const Color(0xFFE8D1B5),
      _ => const Color(0xFFE2E8F0),
    };
  }

  Color get darkBorderColor {
    return switch (this) {
      AppThemePreset.hawaii => const Color(0xFF31514A),
      _ => const Color(0xFF29352D),
    };
  }

  Color get decorativeWoodColor {
    return switch (this) {
      AppThemePreset.hawaii => const Color(0xFF7A4A2D),
      _ => accentColor,
    };
  }

  static AppThemePreset fromId(String id) {
    return AppThemePreset.values.firstWhere(
      (preset) => preset.id == id,
      orElse: () => AppThemePreset.abasto,
    );
  }
}

@immutable
class AppThemeDecoration extends ThemeExtension<AppThemeDecoration> {
  const AppThemeDecoration({
    required this.preset,
    required this.accentColor,
    required this.woodColor,
  });

  final AppThemePreset preset;
  final Color accentColor;
  final Color woodColor;

  bool get isHawaii => preset == AppThemePreset.hawaii;

  @override
  AppThemeDecoration copyWith({
    AppThemePreset? preset,
    Color? accentColor,
    Color? woodColor,
  }) {
    return AppThemeDecoration(
      preset: preset ?? this.preset,
      accentColor: accentColor ?? this.accentColor,
      woodColor: woodColor ?? this.woodColor,
    );
  }

  @override
  AppThemeDecoration lerp(ThemeExtension<AppThemeDecoration>? other, double t) {
    if (other is! AppThemeDecoration) return this;

    return AppThemeDecoration(
      preset: t < 0.5 ? preset : other.preset,
      accentColor:
          Color.lerp(accentColor, other.accentColor, t) ?? other.accentColor,
      woodColor: Color.lerp(woodColor, other.woodColor, t) ?? other.woodColor,
    );
  }
}
