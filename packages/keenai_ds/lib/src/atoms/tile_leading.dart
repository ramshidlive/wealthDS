import 'package:flutter/widgets.dart';

import '../../ds/status_pill.dart';
import '../../tokens/tokens.dart';

/// Visual treatments of a leading tile block on a list row.
///
/// Both variants share the same text column (title · tag, pills + subtitle,
/// caption); they differ only in whether a leading [TileLeading.icon] slot is
/// rendered.
enum TileLeadingVariant {
  /// Renders [TileLeading.icon] before the text column.
  icon,

  /// Text-only layout — no leading slot.
  noIcon,
}

/// Typography scale for the title row ([TileLeading.title] · [TileLeading.tag]).
enum TileLeadingSize {
  /// Title uses [KeenaiTypographyBody.body14Medium].
  md,

  /// Title uses [KeenaiTypographyBody.body16Semibold] (16 / 600 from tokens).
  lg,
}

/// A single status pill rendered on the [TileLeading] meta row.
///
/// Uses [DsStatusPill] under the hood — keep this lightweight so the parent
/// can declare its meta-row content as data.
class TilePill {
  const TilePill({
    required this.label,
    this.tone = DsStatusPillTone.neutral,
  });
  final String label;
  final DsStatusPillTone tone;
}

/// Compact leading block used on transaction / order / asset list rows.
///
/// When [caption] is set, the leading [icon] aligns to the top of the text
/// column (with the title); without a caption, the icon stays vertically
/// centered with the text column.
///
/// [size] scales the title only; tag, subtitle, and caption use
/// [KeenaiTypographyBody.body12Regular] in both sizes.
///
/// Widgets layer only — no Material / Cupertino. All colors, type, spacing,
/// and radii come from the keenai_ds tokens — see `KeenaiColors*`,
/// `KeenaiTypographyBody`, `KeenaiSpacing`, `KeenaiRadius`.
class TileLeading extends StatelessWidget {
  const TileLeading({
    super.key,
    required this.variant,
    required this.title,
    this.size = TileLeadingSize.md,
    this.subtitle,
    this.caption,
    this.tag,
    this.icon,
    this.pills = const <TilePill>[],
  });

  final TileLeadingVariant variant;
  final String title;

  /// Title row typography; [TileLeadingSize.lg] uses [KeenaiTypographyBody.body16Semibold].
  final TileLeadingSize size;

  /// Primary supporting line below the title.
  final String? subtitle;

  /// Tertiary line under [subtitle] — e.g. `Order ID: ...`.
  final String? caption;

  /// Inline tag rendered next to the title (`title · tag`).
  final String? tag;

  /// Leading widget for [TileLeadingVariant.icon] — any glyph or image.
  /// Ignored when [variant] is [TileLeadingVariant.noIcon].
  final Widget? icon;

  /// Status pills rendered inline with [subtitle], using [DsStatusPill] at
  /// [DsStatusPillSize.sm].
  final List<TilePill> pills;

  @override
  Widget build(BuildContext context) {
    final showIcon = variant == TileLeadingVariant.icon && icon != null;
    final hasMeta = pills.isNotEmpty || subtitle != null;
    final alignIconWithTitle = caption != null;
    return Row(
      crossAxisAlignment: alignIconWithTitle
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) ...[
          icon!,
          const SizedBox(width: KeenaiSpacing.space12),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _titleRow(title, tag, size),
              if (hasMeta) ...[
                const SizedBox(height: KeenaiSpacing.space4),
                Wrap(
                  spacing: KeenaiSpacing.space8,
                  runSpacing: KeenaiSpacing.space4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    for (final p in pills)
                      DsStatusPill(
                        label: p.label,
                        tone: p.tone,
                        size: DsStatusPillSize.sm,
                      ),
                    if (subtitle != null)
                      Text(subtitle!, style: _supportingStyle),
                  ],
                ),
              ],
              if (caption != null) ...[
                const SizedBox(height: KeenaiSpacing.space2),
                Text(caption!, style: _supportingStyle),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

TextStyle _titleStyleFor(TileLeadingSize size) {
  return switch (size) {
    TileLeadingSize.md => KeenaiTypographyBody.body14Medium
        .copyWith(color: KeenaiColorsText.main),
    TileLeadingSize.lg => KeenaiTypographyBody.body16Semibold
        .copyWith(color: KeenaiColorsText.main),
  };
}

TextStyle get _supportingStyle =>
    KeenaiTypographyBody.body12Regular.copyWith(color: KeenaiColorsText.muted);

TextStyle get _tagStyle =>
    KeenaiTypographyBody.body12Regular.copyWith(color: KeenaiColorsText.muted);

Widget _titleRow(String title, String? tag, TileLeadingSize size) {
  final titleStyle = _titleStyleFor(size);
  if (tag == null) return Text(title, style: titleStyle);
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    children: [
      Flexible(child: Text(title, style: titleStyle)),
      const SizedBox(width: KeenaiSpacing.space8),
      Text('·', style: _tagStyle),
      const SizedBox(width: KeenaiSpacing.space8),
      Text(tag, style: _tagStyle),
    ],
  );
}

// ─── Reusable glyphs for [TileLeadingVariant.icon] ──────────────────────────

/// Outlined circle with a filled sector — "in progress / pending" look.
class TileLeadingPendingGlyph extends StatelessWidget {
  const TileLeadingPendingGlyph({super.key, this.size = KeenaiSpacing.space40});
  final double size;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _PendingPainter()),
      );
}

/// Filled green circle with a white check — "completed / success" look.
class TileLeadingSuccessGlyph extends StatelessWidget {
  const TileLeadingSuccessGlyph({super.key, this.size = KeenaiSpacing.space40});
  final double size;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _SuccessPainter()),
      );
}

/// 4×4 grid of cells — generic metric / property glyph.
class TileLeadingGridGlyph extends StatelessWidget {
  const TileLeadingGridGlyph({super.key, this.size = KeenaiSpacing.space32});
  final double size;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _GridPainter()),
      );
}

class _PendingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.shortestSide / 2;
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = KeenaiColorsBorder.strong;
    canvas.drawCircle(center, r - 0.75, ring);
    final sector = Paint()..color = KeenaiColorsText.main;
    final rect = Rect.fromCircle(center: center, radius: r - 3);
    canvas.drawArc(rect, -1.5708, -1.5708, true, sector);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SuccessPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.shortestSide / 2;
    canvas.drawCircle(center, r, Paint()..color = KeenaiColorsText.green);
    final tick = Paint()
      ..color = KeenaiColorsSurface.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final p1 = Offset(center.dx - r * 0.35, center.dy);
    final p2 = Offset(center.dx - r * 0.05, center.dy + r * 0.28);
    final p3 = Offset(center.dx + r * 0.40, center.dy - r * 0.20);
    canvas.drawPath(
      Path()
        ..moveTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..lineTo(p3.dx, p3.dy),
      tick,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = KeenaiColorsBorder.strong;
    const cells = 4;
    final cell = size.width / cells;
    final pad = cell * 0.25;
    for (var i = 0; i < cells; i++) {
      for (var j = 0; j < cells; j++) {
        canvas.drawRect(
          Rect.fromLTWH(
            i * cell + pad / 2,
            j * cell + pad / 2,
            cell - pad,
            cell - pad,
          ),
          p,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
