import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/navigation/router.dart';
import 'core/theme/app_theme.dart';
import 'features/profile/presentation/providers/theme_mode_provider.dart';

void main() {
  runApp(const ProviderScope(child: AbastoApp()));
}

class AbastoApp extends ConsumerWidget {
  const AbastoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themePreferenceProvider);
    final themePreset = ref.watch(themePresetPreferenceProvider);

    return MaterialApp.router(
      title: 'Abasto',
      theme: AppTheme.light(themePreset),
      darkTheme: AppTheme.dark(themePreset),
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
