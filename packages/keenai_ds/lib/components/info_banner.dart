import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';

/// Visual tone for [DsInfoBanner] — Figma node `10:22` (InfoBanner).
enum DsInfoBannerTone {
  info,
  warning,
  success,
  danger,
}

/// Inline notice with leading info glyph — Figma `10:22` (InfoBanner).
///
/// Uses only the widgets layer (no Material / Cupertino). The leading mark
/// is drawn with [CustomPainter] so no icon font packages are required.
class DsInfoBanner extends StatelessWidget {
  const DsInfoBanner({
    super.key,
    required this.message,
    this.tone = DsInfoBannerTone.info,
  });

  final String message;
  final DsInfoBannerTone tone;

  static const double _iconSize = KeenaiSpacing.space16;
  static const double _gap = KeenaiSpacing.space8;
  static const EdgeInsets _padding = EdgeInsets.all(KeenaiSpacing.space12);
  static const double _radius = KeenaiRadius.radius12;

  (Color bg, Color border, Color foreground) get _palette {
    switch (tone) {
      case DsInfoBannerTone.info:
        return (
          KeenaiColorsSurface.card,
          KeenaiColorsBorder.strong,
          KeenaiColorsText.muted,
        );
      case DsInfoBannerTone.warning:
        return (
          KeenaiColorsBanner.warningBg,
          KeenaiColorsBanner.warningBorder,
          KeenaiColorsBanner.warningText,
        );
      case DsInfoBannerTone.success:
        return (
          KeenaiColorsBanner.successBg,
          KeenaiColorsBanner.successBorder,
          KeenaiColorsBanner.successText,
        );
      case DsInfoBannerTone.danger:
        return (
          KeenaiColorsBanner.dangerBg,
          KeenaiColorsBanner.dangerBorder,
          KeenaiColorsBanner.dangerText,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final (bg, borderColor, fg) = _palette;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(_radius),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPaint(
              painter: _DsInfoBannerGlyphPainter(color: fg),
              size: const Size.square(_iconSize),
            ),
            const SizedBox(width: _gap),
            Expanded(
              child: Text(
                message,
                style: KeenaiTypographyBody.body14Regular.copyWith(color: fg),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// “i” in a circle — matches Figma 16×16 leading icon proportions.
final class _DsInfoBannerGlyphPainter extends CustomPainter {
  const _DsInfoBannerGlyphPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.15
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;

    final cx = size.width * 0.5;
    final cy = size.height * 0.5;
    final r = size.shortestSide * 0.5 - stroke.strokeWidth * 0.5;
    canvas.drawCircle(Offset(cx, cy), r, stroke);

    final stem = Paint()
      ..color = color
      ..strokeWidth = 1.25
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;
    canvas.drawLine(Offset(cx, cy - 3.2), Offset(cx, cy + 0.8), stem);

    canvas.drawCircle(
      Offset(cx, cy + 4.2),
      1.2,
      Paint()
        ..color = color
        ..isAntiAlias = true,
    );
  }

  @override
  bool shouldRepaint(covariant _DsInfoBannerGlyphPainter oldDelegate) =>
      oldDelegate.color != color;
}
