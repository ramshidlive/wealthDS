import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';
import 'ds_chevron.dart';

/// Vertical alignment of the main row — Figma `DetailListItem` (`14:132`).
enum DsDetailListItemAlign {
  center,
  top,
}

/// Vertical rhythm — Figma `DetailListItem` (`14:132`).
enum DsDetailListItemDensity {
  regular,
  compact,
}

/// Trailing slot — Figma `DetailListItem` (`14:132`).
enum DsDetailListItemTrailing {
  /// Currency (small, muted) + primary figure (16 semibold).
  metric,

  /// Single bold line (e.g. `24.2K`).
  text,
}

/// Rich list row with optional leading, supporting line, and metric/text trailing.
///
/// Figma node `14:132` (DetailListItem). Widgets layer only (no Material / Cupertino).
class DsDetailListItem extends StatelessWidget {
  const DsDetailListItem({
    super.key,
    required this.title,
    this.supportingText = '6 of 6 · USD 4,030 each',
    this.showSupporting = true,
    this.showTitleInfo = false,
    this.showLeadingIcon = false,
    this.showChevron = false,
    this.align = DsDetailListItemAlign.center,
    this.density = DsDetailListItemDensity.regular,
    this.trailing = DsDetailListItemTrailing.metric,
    this.metricCurrency = 'USD',
    this.metricValue = '24.2K',
    this.showMetricCurrency = true,
    this.trailingText = '24.2K',
  });

  final String title;
  final String supportingText;
  final bool showSupporting;
  final bool showTitleInfo;
  final bool showLeadingIcon;
  final bool showChevron;
  final DsDetailListItemAlign align;
  final DsDetailListItemDensity density;
  final DsDetailListItemTrailing trailing;

  /// Small label before [metricValue] when [trailing] is [DsDetailListItemTrailing.metric].
  final String metricCurrency;

  /// Primary figure when [trailing] is [DsDetailListItemTrailing.metric].
  final String metricValue;

  /// Figma alternates rows with/without the small currency tag.
  final bool showMetricCurrency;

  /// Used when [trailing] is [DsDetailListItemTrailing.text].
  final String trailingText;

  double get _outerGap =>
      density == DsDetailListItemDensity.regular
          ? KeenaiSpacing.space12
          : KeenaiSpacing.space8;

  CrossAxisAlignment get _rowCrossAxis =>
      align == DsDetailListItemAlign.top
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: _rowCrossAxis,
      children: [
        if (showLeadingIcon) ...[
          DecoratedBox(
            decoration: BoxDecoration(
              color: KeenaiColorsSurface.card,
              borderRadius: BorderRadius.circular(KeenaiRadius.radius8),
              border: Border.all(color: KeenaiColorsBorder.light),
            ),
            child: const SizedBox(
              width: 40,
              height: 40,
            ),
          ),
          SizedBox(width: _outerGap),
        ],
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: KeenaiTypographyBody.body14Medium
                                .copyWith(color: KeenaiColorsText.main),
                          ),
                        ),
                        if (showTitleInfo) ...[
                          const SizedBox(width: KeenaiSpacing.space4),
                          CustomPaint(
                            size: const Size.square(14),
                            painter: _DsTitleInfoGlyphPainter(
                              color: KeenaiColorsText.muted,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (showSupporting) ...[
                      const SizedBox(height: KeenaiSpacing.space4),
                      Text(
                        supportingText,
                        style: KeenaiTypographyBody.body12Regular
                            .copyWith(color: KeenaiColorsText.muted),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: KeenaiSpacing.space20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (trailing == DsDetailListItemTrailing.metric)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        if (showMetricCurrency) ...[
                          Text(
                            metricCurrency,
                            style: KeenaiTypographyBody.body10Semibold
                                .copyWith(color: KeenaiColorsText.muted),
                          ),
                          const SizedBox(width: KeenaiSpacing.space4),
                        ],
                        Text(
                          metricValue,
                          style: KeenaiTypographyBody.body16Semibold
                              .copyWith(color: KeenaiColorsText.main),
                        ),
                      ],
                    )
                  else
                    Text(
                      trailingText,
                      style: KeenaiTypographyBody.body16Semibold
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
        ),
      ],
    );
  }
}

/// 14×14 info glyph beside title — Figma `title-info`.
final class _DsTitleInfoGlyphPainter extends CustomPainter {
  _DsTitleInfoGlyphPainter({required this.color});

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
  bool shouldRepaint(covariant _DsTitleInfoGlyphPainter oldDelegate) =>
      oldDelegate.color != color;
}
