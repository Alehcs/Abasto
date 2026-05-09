import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme_preset.dart';
import '../../../../shared/widgets/section_title.dart';
import '../providers/theme_mode_provider.dart';

class ThemeSettingsPage extends ConsumerWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themePreferenceProvider);
    final preset = ref.watch(themePresetPreferenceProvider);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final modeNotifier = ref.read(themePreferenceProvider.notifier);
    final presetNotifier = ref.read(themePresetPreferenceProvider.notifier);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Temas'), centerTitle: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Modo'),
            _ThemeModeTile(
              icon: Icons.brightness_auto_rounded,
              label: 'Sistema',
              selected: themeMode == ThemeMode.system,
              onTap: modeNotifier.useSystem,
            ),
            const SizedBox(height: 10),
            _ThemeModeTile(
              icon: Icons.light_mode_outlined,
              label: 'Claro',
              selected: themeMode == ThemeMode.light,
              onTap: modeNotifier.useLight,
            ),
            const SizedBox(height: 10),
            _ThemeModeTile(
              icon: Icons.dark_mode_outlined,
              label: 'Oscuro',
              selected: themeMode == ThemeMode.dark,
              onTap: modeNotifier.useDark,
            ),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Paleta'),
            GridView.builder(
              itemCount: AppThemePreset.values.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.18,
              ),
              itemBuilder: (context, index) {
                final item = AppThemePreset.values[index];
                return _ThemePresetCard(
                  preset: item,
                  selected: item == preset,
                  onTap: () => presetNotifier.select(item),
                );
              },
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.tune_rounded, color: colors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'La paleta elegida queda guardada localmente.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeTile extends StatelessWidget {
  const _ThemeModeTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected ? colors.primary : colors.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? colors.onSurface
                        : colors.onSurfaceVariant,
                  ),
                ),
              ),
              if (selected)
                Icon(Icons.check_circle_rounded, color: colors.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemePresetCard extends StatelessWidget {
  const _ThemePresetCard({
    required this.preset,
    required this.selected,
    required this.onTap,
  });

  final AppThemePreset preset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      color: selected ? colors.primaryContainer : colors.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _Swatch(color: preset.seedColor),
                  const SizedBox(width: 7),
                  _Swatch(color: preset.accentColor),
                  const Spacer(),
                  if (selected)
                    Icon(Icons.check_circle_rounded, color: colors.primary),
                ],
              ),
              const Spacer(),
              Text(
                preset.label,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                preset.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
    );
  }
}
