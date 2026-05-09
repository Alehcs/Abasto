import 'package:flutter/material.dart';

import '../../core/theme/theme_preset.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;

  const AppHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final deco = theme.extension<AppThemeDecoration>();

    if (deco?.isHawaii ?? false) {
      return _HawaiiHeader(title: title, subtitle: subtitle, trailing: trailing);
    }
    return _DefaultHeader(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      theme: theme,
      colors: colors,
    );
  }
}

// ─── DEFAULT ─────────────────────────────────────────────────────────────────

class _DefaultHeader extends StatelessWidget {
  const _DefaultHeader({
    required this.title,
    required this.subtitle,
    required this.theme,
    required this.colors,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;
  final ThemeData theme;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: BoxDecoration(color: colors.primaryContainer),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onPrimaryContainer.withValues(alpha: 0.78),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                  ),
                  if (trailing != null) ...[const SizedBox(width: 12), trailing!],
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
// Inspired by Disney's Polynesian Village Resort:
// deep lagoon teal + koa wood + coral hibiscus + authentic tapa cloth patterns.

class _HawaiiHeader extends StatelessWidget {
  const _HawaiiHeader({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;

  // Lagoon gradient — from deep ocean to turquoise surface
  static const _lagoonDeep    = Color(0xFF003840);
  static const _lagoonMid     = Color(0xFF005F6B);
  static const _lagoonLight   = Color(0xFF007A82);
  // Koa wood tones
  static const _koaDark       = Color(0xFF3E2723);
  static const _koaMedium     = Color(0xFF5D4037);
  static const _koaLight      = Color(0xFF7A4A2D);
  // Accents
  static const _hibiscus      = Color(0xFFE8753B);
  static const _palmWhite     = Colors.white;
  static const _cream         = Color(0xFFFFF0D0);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_lagoonDeep, _lagoonMid, _lagoonLight],
            stops: [0.0, 0.50, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // ── Ambient palm silhouettes ──────────────────────────
            Positioned(
              right: -22, top: 0,
              child: Opacity(
                opacity: 0.20,
                child: Transform.rotate(
                  angle: 0.12,
                  child: const Icon(Icons.park_rounded, size: 150, color: _palmWhite),
                ),
              ),
            ),
            Positioned(
              right: 68, top: 18,
              child: Opacity(
                opacity: 0.13,
                child: Transform.rotate(
                  angle: -0.28,
                  child: const Icon(Icons.eco_rounded, size: 72, color: _palmWhite),
                ),
              ),
            ),
            // ── Hibiscus accent (coral spark) ─────────────────────
            Positioned(
              right: 16, bottom: 20,
              child: Opacity(
                opacity: 0.38,
                child: const Icon(Icons.local_florist_rounded, size: 28, color: _hibiscus),
              ),
            ),
            Positioned(
              right: 46, bottom: 32,
              child: Opacity(
                opacity: 0.20,
                child: const Icon(Icons.spa_rounded, size: 20, color: _hibiscus),
              ),
            ),
            // ── Authentic tapa cloth pattern ──────────────────────
            Positioned.fill(
              child: CustomPaint(painter: _TapaClothPainter()),
            ),
            // ── Content ───────────────────────────────────────────
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subtitle.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: _palmWhite.withValues(alpha: 0.65),
                              letterSpacing: 1.8,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: _palmWhite,
                              letterSpacing: -0.5,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Koa wood tiki medallion
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          colors: [_koaMedium, _koaDark],
                          center: Alignment(-0.3, -0.3),
                        ),
                        border: Border.all(color: _koaLight, width: 2.5),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x60000000),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.shopping_cart_rounded,
                          color: _cream,
                          size: 24,
                        ),
                      ),
                    ),
                    if (trailing != null) ...[const SizedBox(width: 10), trailing!],
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

// Authentic Polynesian tapa cloth pattern:
// Row 1 (bottom): chevron zigzag border
// Row 2: diamond grid with manulua triangles
// Row 3: thin horizontal line with brickwork dots
class _TapaClothPainter extends CustomPainter {
  static const _inkLight  = Color(0x20FFFFFF);
  static const _inkMedium = Color(0x16FFFFFF);
  static const _coral     = Color(0x1AE8753B);

  @override
  void paint(Canvas canvas, Size size) {
    final lightPaint  = Paint()..color = _inkLight  ..style = PaintingStyle.fill;
    final medPaint    = Paint()..color = _inkMedium ..style = PaintingStyle.fill;
    final coralPaint  = Paint()..color = _coral     ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = _inkLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // ── Band 1: Chevron zigzag at the very bottom ──────────────────
    const chevronH = 14.0;
    const chevronW = 16.0;
    final chevronY = size.height - 4;
    final chevronPath = Path();
    chevronPath.moveTo(0, chevronY);
    var up = true;
    for (var x = 0.0; x <= size.width + chevronW; x += chevronW) {
      chevronPath.lineTo(x, up ? chevronY - chevronH : chevronY);
      up = !up;
    }
    canvas.drawPath(chevronPath, strokePaint);

    // ── Band 2: Diamond grid (manulua) ────────────────────────────
    const diamondBandY = 0.0;
    const dSize  = 10.0;
    const dStepX = 22.0;
    const dStepY = 22.0;

    for (var row = 0; row < 2; row++) {
      final baseY = diamondBandY + row * dStepY + (size.height * 0.18);
      final offset = row.isOdd ? dStepX / 2 : 0.0;
      for (var x = offset; x < size.width - 20; x += dStepX) {
        // Diamond
        final diamond = Path()
          ..moveTo(x, baseY - dSize)
          ..lineTo(x + dSize, baseY)
          ..lineTo(x, baseY + dSize)
          ..lineTo(x - dSize, baseY)
          ..close();
        canvas.drawPath(diamond, row.isEven ? lightPaint : medPaint);

        // Manulua triangle (inverted, diagonal)
        final tri = Path()
          ..moveTo(x + dSize + 2, baseY - dSize + 2)
          ..lineTo(x + dSize * 2, baseY)
          ..lineTo(x + dSize + 2, baseY + dSize - 2)
          ..close();
        canvas.drawPath(tri, coralPaint);
      }
    }

    // ── Band 3: Brickwork dot row ──────────────────────────────────
    const dotSize = 3.5;
    const dotStep = 14.0;
    final dotBaseY = size.height * 0.60;

    for (var col = 0; col < 2; col++) {
      final rowY = dotBaseY + col * 10;
      final xOff = col.isOdd ? dotStep / 2 : 0.0;
      for (var x = xOff; x < size.width - 20; x += dotStep) {
        canvas.drawCircle(Offset(x, rowY), dotSize / 2, medPaint);
      }
      canvas.drawLine(
        Offset(0, rowY + dotSize),
        Offset(size.width - 20, rowY + dotSize),
        strokePaint..color = _inkMedium,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TapaClothPainter oldDelegate) => false;
}
