// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themePreferenceHash() => r'73673b29b0d4959cc975a4feaaa6db3ed12c5fda';

/// See also [ThemePreference].
@ProviderFor(ThemePreference)
final themePreferenceProvider =
    NotifierProvider<ThemePreference, ThemeMode>.internal(
      ThemePreference.new,
      name: r'themePreferenceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themePreferenceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemePreference = Notifier<ThemeMode>;
String _$themePresetPreferenceHash() =>
    r'cc934ad42f0989543c67d9b16b045710fa483284';

/// See also [ThemePresetPreference].
@ProviderFor(ThemePresetPreference)
final themePresetPreferenceProvider =
    NotifierProvider<ThemePresetPreference, AppThemePreset>.internal(
      ThemePresetPreference.new,
      name: r'themePresetPreferenceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themePresetPreferenceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemePresetPreference = Notifier<AppThemePreset>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
