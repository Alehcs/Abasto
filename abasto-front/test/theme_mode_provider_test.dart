import 'package:abasto/core/database/app_database.dart';
import 'package:abasto/core/database/database_provider.dart';
import 'package:abasto/core/theme/theme_preset.dart';
import 'package:abasto/features/profile/presentation/providers/theme_mode_provider.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('persists and reloads the selected theme mode', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);

    expect(container.read(themePreferenceProvider), ThemeMode.light);

    await container.read(themePreferenceProvider.notifier).useDark();

    final saved = await (database.select(
      database.appPreferences,
    )..where((table) => table.key.equals('theme_mode'))).getSingle();

    expect(saved.value, ThemeMode.dark.name);

    final reloadedContainer = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(reloadedContainer.dispose);

    expect(reloadedContainer.read(themePreferenceProvider), ThemeMode.light);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(reloadedContainer.read(themePreferenceProvider), ThemeMode.dark);
  });

  test('persists and reloads the selected theme preset', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);

    expect(
      container.read(themePresetPreferenceProvider),
      AppThemePreset.abasto,
    );

    await container
        .read(themePresetPreferenceProvider.notifier)
        .select(AppThemePreset.hawaii);

    final saved = await (database.select(
      database.appPreferences,
    )..where((table) => table.key.equals('theme_preset'))).getSingle();

    expect(saved.value, AppThemePreset.hawaii.id);
    expect(AppThemePreset.fromId('hawaii'), AppThemePreset.hawaii);

    final reloadedContainer = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(reloadedContainer.dispose);

    expect(
      reloadedContainer.read(themePresetPreferenceProvider),
      AppThemePreset.abasto,
    );
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(
      reloadedContainer.read(themePresetPreferenceProvider),
      AppThemePreset.hawaii,
    );
  });
}
