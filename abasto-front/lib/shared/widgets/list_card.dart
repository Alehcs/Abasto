import 'package:flutter/material.dart';

import '../../core/theme/theme_preset.dart';

class ListCard extends StatelessWidget {
  final String type;
  final String title;
  final String meta;
  final String remaining;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ListCard({
    super.key,
    required this.type,
    required this.title,
    required this.meta,
    required this.remaining,
    required this.icon,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final deco = theme.extension<AppThemeDecoration>();
    final isHawaii = deco?.isHawaii ?? false;

    return isHawaii
        ? _HawaiiListCard(
            type: type, title: title, meta: meta, remaining: remaining,
            icon: icon, onTap: onTap, trailing: trailing,
            theme: theme, colors: colors, deco: deco!,
          )
        : _DefaultListCard(
            type: type, title: title, meta: meta, remaining: remaining,
            icon: icon, onTap: onTap, trailing: trailing,
            theme: theme, colors: colors,
          );
  }
}

// ─── DEFAULT ─────────────────────────────────────────────────────────────────

class _DefaultListCard extends StatelessWidget {
  const _DefaultListCard({
    required this.type, required this.title, required this.meta,
    required this.remaining, required this.icon,
    required this.theme, required this.colors,
    this.onTap, this.trailing,
  });

  final String type, title, meta, remaining;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;
  final ThemeData theme;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: colors.primary, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(type, style: theme.textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
                        const SizedBox(height: 2),
                        Text(title, style: theme.textTheme.titleSmall?.copyWith(fontSize: 15, fontWeight: FontWeight.w600, color: colors.onSurface)),
                        const SizedBox(height: 4),
                        Text(meta, style: theme.textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  trailing ?? Icon(Icons.chevron_right_rounded, color: colors.onSurfaceVariant),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pendientes', style: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(100)),
                    child: Text(remaining, style: theme.textTheme.bodySmall?.copyWith(fontSize: 13, fontWeight: FontWeight.w600, color: colors.onSurfaceVariant)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── HAWAII ───────────────────────────────────────────────────────────────────
// Warm cream card with koa wood medallion icon + coral sand pill.
// Evokes the Polynesian Village Resort blend of natural materials + tropical warmth.

class _HawaiiListCard extends StatelessWidget {
  const _HawaiiListCard({
    required this.type, required this.title, required this.meta,
    required this.remaining, required this.icon,
    required this.theme, required this.colors, required this.deco,
    this.onTap, this.trailing,
  });

  final String type, title, meta, remaining;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;
  final ThemeData theme;
  final ColorScheme colors;
  final AppThemeDecoration deco;

  static const _cardBg  = Color(0xFFFFFBF2);
  static const _koaDark = Color(0xFF3E2723);
  static const _koaMid  = Color(0xFF5D4037);
  static const _koaLt   = Color(0xFF7A4A2D);
  static const _cream   = Color(0xFFFFF0D0);
  static const _sand    = Color(0xFFF0DDB8);
  static const _border  = Color(0xFFE8D1B5);
  static const _text    = Color(0xFF2D1A00);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _border, width: 1.2),
        boxShadow: const [
          BoxShadow(color: Color(0x0C000000), blurRadius: 10, offset: Offset(0, 3)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          splashColor: colors.primary.withValues(alpha: 0.08),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Koa wood medallion
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          colors: [_koaMid, _koaDark],
                          center: Alignment(-0.3, -0.3),
                        ),
                        border: Border.all(color: _koaLt, width: 2),
                        boxShadow: const [BoxShadow(color: Color(0x28000000), blurRadius: 6, offset: Offset(0, 2))],
                      ),
                      child: Icon(icon, color: _cream, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            type.toUpperCase(),
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _koaLt.withValues(alpha: 0.65), letterSpacing: 1.5),
                          ),
                          const SizedBox(height: 3),
                          Text(title, style: theme.textTheme.titleSmall?.copyWith(fontSize: 15, fontWeight: FontWeight.w700, color: _text)),
                          const SizedBox(height: 3),
                          Text(meta, style: theme.textTheme.bodySmall?.copyWith(color: _koaLt.withValues(alpha: 0.60))),
                        ],
                      ),
                    ),
                    trailing ?? Icon(Icons.chevron_right_rounded, color: _koaLt.withValues(alpha: 0.55)),
                  ],
                ),
                const SizedBox(height: 10),
                // Gradient divider
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [_koaLt.withValues(alpha: 0.0), _koaLt.withValues(alpha: 0.22), _koaLt.withValues(alpha: 0.0)]),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pendientes', style: theme.textTheme.bodySmall?.copyWith(color: _koaLt.withValues(alpha: 0.65), fontWeight: FontWeight.w500)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _sand,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: _koaLt.withValues(alpha: 0.25)),
                      ),
                      child: Text(remaining, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _koaDark)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
