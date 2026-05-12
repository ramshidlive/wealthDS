import 'package:flutter/widgets.dart';

import 'ds_chevron.dart';
import '../tokens/tokens.dart';

/// Density for [DsKeyValueRow] — Figma `KeyValueRow` (`12:26`).
enum DsKeyValueRowDensity {
  /// `gap-[24px]` between key and value groups.
  regular,

  /// `gap-[12px]` between key and value groups.
  dense,
}

/// Single key / value row with optional info, chevron, and divider — Figma `12:26`.
///
/// Uses only the widgets layer (no Material / Cupertino).
class DsKeyValueRow extends StatelessWidget {
  const DsKeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.density = DsKeyValueRowDensity.regular,
    this.showInfoIcon = false,
    this.showChevron = false,
    this.showDivider = false,
  });

  final String label;
  final String value;
  final DsKeyValueRowDensity density;
  final bool showInfoIcon;
  final bool showChevron;
  final bool showDivider;

  double get _rowGap =>
      density == DsKeyValueRowDensity.regular
          ? KeenaiSpacing.space24
          : KeenaiSpacing.space12;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: KeenaiTypographyBody.body14Regular
                          .copyWith(color: KeenaiColorsText.muted),
                    ),
                  ),
                  if (showInfoIcon) ...[
                    const SizedBox(width: KeenaiSpacing.space4),
                    CustomPaint(
                      size: const Size.square(14),
                      painter: _DsKeyValueInfoGlyphPainter(
                        color: KeenaiColorsText.muted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: _rowGap),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: KeenaiTypographyBody.body14Medium
                      .copyWith(color: KeenaiColorsText.main),
                ),
                if (showChevron) ...[
                  const SizedBox(width: KeenaiSpacing.space4),
                  DsChevron(
                    direction: DsChevronDirection.right,
                    color: KeenaiColorsText.muted,
                    size: KeenaiSpacing.space20,
                  ),
                ],
              ],
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: KeenaiSpacing.space8),
          Container(
            height: 1,
            color: KeenaiColorsBorder.light,
          ),
        ],
      ],
    );
  }
}

/// 14×14 “i” glyph — Figma `key-info` beside label.
final class _DsKeyValueInfoGlyphPainter extends CustomPainter {
  _DsKeyValueInfoGlyphPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;

    final cx = size.width * 0.5;
    final cy = size.height * 0.5;
    final r = size.shortestSide * 0.5 - stroke.strokeWidth * 0.5;
    canvas.drawCircle(Offset(cx, cy), r, stroke);

    final stem = Paint()
      ..color = color
      ..strokeWidth = 1.15
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;
    canvas.drawLine(Offset(cx, cy - 2.8), Offset(cx, cy + 0.6), stem);
    canvas.drawCircle(
      Offset(cx, cy + 3.4),
      1.0,
      Paint()..color = color..isAntiAlias = true,
    );
  }

  @override
  bool shouldRepaint(covariant _DsKeyValueInfoGlyphPainter oldDelegate) =>
      oldDelegate.color != color;
}
