import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/theme_preset.dart';

class ShellScaffold extends StatelessWidget {
  final Widget child;
  const ShellScaffold({super.key, required this.child});

  static const _tabs = [
    (path: '/home',    label: 'Inicio',   icon: Icons.home_outlined,          activeIcon: Icons.home_rounded),
    (path: '/lists',   label: 'Listas',   icon: Icons.format_list_bulleted,    activeIcon: Icons.format_list_bulleted),
    (path: '/history', label: 'Historial',icon: Icons.history,                 activeIcon: Icons.history),
    (path: '/profile', label: 'Perfil',   icon: Icons.person_outline_rounded,  activeIcon: Icons.person_rounded),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final idx = _tabs.indexWhere((t) => location.startsWith(t.path));
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final current = _currentIndex(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final deco = theme.extension<AppThemeDecoration>();
    final isHawaii = deco?.isHawaii ?? false;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: child,
      bottomNavigationBar: _NavBar(
        current: current,
        tabs: _tabs,
        colors: colors,
        theme: theme,
        isHawaii: isHawaii,
        woodColor: deco?.woodColor,
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({
    required this.current,
    required this.tabs,
    required this.colors,
    required this.theme,
    required this.isHawaii,
    this.woodColor,
  });

  final int current;
  final List<({String path, String label, IconData icon, IconData activeIcon})> tabs;
  final ColorScheme colors;
  final ThemeData theme;
  final bool isHawaii;
  final Color? woodColor;

  @override
  Widget build(BuildContext context) {
    final navBg = isHawaii ? const Color(0xFFFFFBF2) : colors.surface;
    final borderColor = isHawaii ? const Color(0xFFE8D1B5) : colors.outlineVariant;

    return Container(
      decoration: BoxDecoration(
        color: navBg,
        border: Border(top: BorderSide(color: borderColor, width: isHawaii ? 1.5 : 1.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tapa accent strip at the very top of nav bar (Hawaii only)
          if (isHawaii)
            SizedBox(
              height: 10,
              width: double.infinity,
              child: CustomPaint(
                painter: _NavTapaPainter(
                  wood: woodColor ?? const Color(0xFF7A4A2D),
                  coral: colors.secondary,
                ),
              ),
            ),
          SafeArea(
            top: false,
            child: SizedBox(
              height: 58,
              child: Row(
                children: List.generate(tabs.length, (i) {
                  final tab = tabs[i];
                  final selected = i == current;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => GoRouter.of(context).go(tab.path),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isHawaii && selected)
                            // Active indicator: small koa circle behind icon
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.primary.withValues(alpha: 0.12),
                              ),
                              child: Icon(tab.activeIcon, size: 20, color: colors.primary),
                            )
                          else
                            Icon(
                              selected ? tab.activeIcon : tab.icon,
                              size: 22,
                              color: selected ? colors.primary : colors.onSurfaceVariant,
                            ),
                          const SizedBox(height: 3),
                          Text(
                            tab.label,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 10,
                              fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
                              color: selected ? colors.primary : colors.onSurfaceVariant,
                              letterSpacing: isHawaii && selected ? 0.3 : 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Tiny tapa strip at top of nav: alternating diamonds + dots in koa tones.
class _NavTapaPainter extends CustomPainter {
  const _NavTapaPainter({required this.wood, required this.coral});

  final Color wood;
  final Color coral;

  @override
  void paint(Canvas canvas, Size size) {
    final woodPaint  = Paint()..color = wood.withValues(alpha: 0.22) ..style = PaintingStyle.fill;
    final coralPaint = Paint()..color = coral.withValues(alpha: 0.20)..style = PaintingStyle.fill;
    final linePaint  = Paint()..color = wood.withValues(alpha: 0.18) ..style = PaintingStyle.stroke ..strokeWidth = 0.8;

    const cy    = 5.0;
    const dSize = 3.5;
    const step  = 12.0;

    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), linePaint);

    for (var x = dSize; x < size.width; x += step) {
      final diamond = Path()
        ..moveTo(x, cy - dSize)
        ..lineTo(x + dSize, cy)
        ..lineTo(x, cy + dSize)
        ..lineTo(x - dSize, cy)
        ..close();
      canvas.drawPath(diamond, x % (step * 2) < step ? woodPaint : coralPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _NavTapaPainter old) =>
      old.wood != wood || old.coral != coral;
}
