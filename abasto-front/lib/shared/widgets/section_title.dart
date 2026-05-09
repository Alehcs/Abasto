import 'package:flutter/material.dart';

import '../../core/theme/theme_preset.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const SectionTitle({
    super.key,
    required this.title,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final deco = theme.extension<AppThemeDecoration>();
    final isHawaii = deco?.isHawaii ?? false;

    return Padding(
      padding: EdgeInsets.only(bottom: isHawaii ? 10 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isHawaii ? title.toUpperCase() : title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: isHawaii ? 13 : 16,
                  fontWeight: FontWeight.w800,
                  color: isHawaii
                      ? deco!.woodColor.withValues(alpha: 0.85)
                      : colors.onSurface,
                  letterSpacing: isHawaii ? 2.0 : 0,
                ),
              ),
              if (action != null)
                InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: onAction,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(
                      action!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: colors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (isHawaii) ...[
            const SizedBox(height: 6),
            SizedBox(
              height: 16,
              width: double.infinity,
              child: CustomPaint(
                painter: _TapaDividerPainter(
                  wood: deco!.woodColor,
                  coral: deco.accentColor,
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }
}

// Authentic tapa cloth divider: diamonds + manulua triangles + chevron accent.
// Mirrors the tapa cloth patterns found throughout the Polynesian Village Resort.
class _TapaDividerPainter extends CustomPainter {
  const _TapaDividerPainter({required this.wood, required this.coral});

  final Color wood;
  final Color coral;

  @override
  void paint(Canvas canvas, Size size) {
    final woodFill   = Paint()..color = wood.withValues(alpha: 0.28)  ..style = PaintingStyle.fill;
    final woodStroke = Paint()..color = wood.withValues(alpha: 0.22)  ..style = PaintingStyle.stroke ..strokeWidth = 1.1;
    final coralFill  = Paint()..color = coral.withValues(alpha: 0.30) ..style = PaintingStyle.fill;

    const cy     = 8.0;   // center y
    const dSize  = 6.0;   // diamond radius
    const step   = 16.0;  // spacing

    // Base horizontal line
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), woodStroke);

    // Diamond + manulua triangle repeating pattern
    for (var x = dSize; x < size.width - dSize; x += step) {
      // Diamond
      final diamond = Path()
        ..moveTo(x, cy - dSize)
        ..lineTo(x + dSize, cy)
        ..lineTo(x, cy + dSize)
        ..lineTo(x - dSize, cy)
        ..close();
      canvas.drawPath(diamond, woodFill);

      // Manulua: small inverted triangle nestled between diamonds
      final tri = Path()
        ..moveTo(x + dSize, cy - dSize + 2)
        ..lineTo(x + dSize * 1.7, cy)
        ..lineTo(x + dSize, cy + dSize - 2)
        ..close();
      canvas.drawPath(tri, coralFill);
    }

    // Chevron accent dots on the top edge
    for (var x = 4.0; x < size.width; x += 8.0) {
      canvas.drawCircle(Offset(x, 1.5), 1.2, woodStroke..style = PaintingStyle.fill ..color = wood.withValues(alpha: 0.16));
    }
  }

  @override
  bool shouldRepaint(covariant _TapaDividerPainter old) =>
      old.wood != wood || old.coral != coral;
}
