import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/theme/theme_preset.dart';

part 'theme_mode_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemePreference extends _$ThemePreference {
  static const _themeModeKey = 'theme_mode';

  @override
  ThemeMode build() {
    _loadSavedTheme();
    return ThemeMode.light;
  }

  Future<void> useSystem() => _save(ThemeMode.system);

  Future<void> useLight() => _save(ThemeMode.light);

  Future<void> useDark() => _save(ThemeMode.dark);

  Future<void> _loadSavedTheme() async {
    final database = ref.read(appDatabaseProvider);
    final preference = await (database.select(
      database.appPreferences,
    )..where((table) => table.key.equals(_themeModeKey))).getSingleOrNull();

    if (preference == null) return;
    state = _parse(preference.value);
  }

  Future<void> _save(ThemeMode mode) async {
    state = mode;

    final database = ref.read(appDatabaseProvider);
    await database
        .into(database.appPreferences)
        .insertOnConflictUpdate(
          AppPreferencesCompanion.insert(
            key: _themeModeKey,
            value: mode.name,
            updatedAt: DateTime.now(),
          ),
        );
  }

  ThemeMode _parse(String value) {
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.light,
    );
  }
}

@Riverpod(keepAlive: true)
class ThemePresetPreference extends _$ThemePresetPreference {
  static const _themePresetKey = 'theme_preset';

  @override
  AppThemePreset build() {
    _loadSavedPreset();
    return AppThemePreset.abasto;
  }

  Future<void> select(AppThemePreset preset) async {
    state = preset;

    final database = ref.read(appDatabaseProvider);
    await database
        .into(database.appPreferences)
        .insertOnConflictUpdate(
          AppPreferencesCompanion.insert(
            key: _themePresetKey,
            value: preset.id,
            updatedAt: DateTime.now(),
          ),
        );
  }

  Future<void> _loadSavedPreset() async {
    final database = ref.read(appDatabaseProvider);
    final preference = await (database.select(
      database.appPreferences,
    )..where((table) => table.key.equals(_themePresetKey))).getSingleOrNull();

    if (preference == null) return;
    state = AppThemePreset.fromId(preference.value);
  }
}
