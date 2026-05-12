import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';
import 'status_pill.dart';

/// Trailing layout for [DsAssetListItem] — Figma `trailing` prop (`41:98`).
enum DsAssetListItemTrailing {
  /// Two-line trailing: primary value + currency, then secondary (e.g. qty).
  sub,

  /// Single bold line (e.g. `145.20 K`).
  single,
}

/// Row for asset / holding lists — Figma node `41:98` (AssetListItem).
///
/// Uses only the widgets layer (no Material / Cupertino).
class DsAssetListItem extends StatelessWidget {
  const DsAssetListItem({
    super.key,
    required this.title,
    this.assetTagLabel = 'Stock',
    this.showAssetTag = true,
    this.showChevron = true,
    this.showOrderType = false,
    this.showOrderStatus = false,
    this.orderTypeLabel = 'S',
    this.orderTypeTone = DsStatusPillTone.danger,
    this.orderStatus = 'FAILED',
    this.showValue = true,
    this.valueText = 'Qty 600',
    this.trailing = DsAssetListItemTrailing.sub,
    this.trailingPrimaryValue = '145.20',
    this.trailingCurrency = 'USD',
    this.trailingSecondaryValue = 'Qty 600',
    this.trailingSingleLine = '145.20 K',
    this.contentWidth = 353,
    this.titleMaxLines = 1,
  });

  final String title;
  final String assetTagLabel;
  final bool showAssetTag;
  final bool showChevron;
  final bool showOrderType;
  final bool showOrderStatus;
  final String orderTypeLabel;
  final DsStatusPillTone orderTypeTone;
  final String orderStatus;
  final bool showValue;
  final String? valueText;
  final DsAssetListItemTrailing trailing;
  final String trailingPrimaryValue;
  final String trailingCurrency;
  final String trailingSecondaryValue;
  final String trailingSingleLine;
  final double contentWidth;
  final int titleMaxLines;

  bool get _hasMetaRow =>
      showOrderType || showOrderStatus || (showValue && (valueText?.isNotEmpty ?? false));

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: KeenaiColorsBorder.light, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: KeenaiSpacing.space16),
        child: SizedBox(
          width: contentWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _TitleRow(
                      title: title,
                      assetTagLabel: assetTagLabel,
                      showAssetTag: showAssetTag,
                      titleMaxLines: titleMaxLines,
                    ),
                    if (_hasMetaRow) ...[
                      const SizedBox(height: KeenaiSpacing.space4),
                      _MetaRow(
                        showOrderType: showOrderType,
                        showOrderStatus: showOrderStatus,
                        orderTypeLabel: orderTypeLabel,
                        orderTypeTone: orderTypeTone,
                        orderStatus: orderStatus,
                        showValue: showValue,
                        valueText: valueText,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: KeenaiSpacing.space32),
              _TrailingBlock(
                trailing: trailing,
                showChevron: showChevron,
                trailingPrimaryValue: trailingPrimaryValue,
                trailingCurrency: trailingCurrency,
                trailingSecondaryValue: trailingSecondaryValue,
                trailingSingleLine: trailingSingleLine,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({
    required this.title,
    required this.assetTagLabel,
    required this.showAssetTag,
    required this.titleMaxLines,
  });

  final String title;
  final String assetTagLabel;
  final bool showAssetTag;
  final int titleMaxLines;

  @override
  Widget build(BuildContext context) {
    final titleText = Text(
      title,
      maxLines: titleMaxLines,
      overflow:
          titleMaxLines > 1 ? TextOverflow.visible : TextOverflow.ellipsis,
      style: KeenaiTypographyBody.body14Medium
          .copyWith(color: KeenaiColorsText.main),
    );

    if (!showAssetTag) {
      return titleText;
    }

    // Interpunct + label use the same line height as the title so alphabetic
    // baselines line up with `CrossAxisAlignment.baseline` (the old dot Row
    // used `start`, which top-aligned a 12px label with 14px title).
    final tagStyle = KeenaiTypographyBody.body12Regular
        .copyWith(
      color: KeenaiColorsText.muted,
      height: KeenaiTypographyBody.body14Medium.height,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: titleText,
        ),
        const SizedBox(width: KeenaiSpacing.space6),
        Text('\u00B7', style: tagStyle),
        const SizedBox(width: KeenaiSpacing.space6),
        Text(assetTagLabel, style: tagStyle),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.showOrderType,
    required this.showOrderStatus,
    required this.orderTypeLabel,
    required this.orderTypeTone,
    required this.orderStatus,
    required this.showValue,
    required this.valueText,
  });

  final bool showOrderType;
  final bool showOrderStatus;
  final String orderTypeLabel;
  final DsStatusPillTone orderTypeTone;
  final String orderStatus;
  final bool showValue;
  final String? valueText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showOrderType) ...[
          DsStatusPill(
            label: orderTypeLabel,
            size: DsStatusPillSize.sm,
            tone: orderTypeTone,
          ),
          const SizedBox(width: KeenaiSpacing.space8),
        ],
        if (showOrderStatus) ...[
          DsStatusPill(
            label: orderStatus,
            size: DsStatusPillSize.sm,
            tone: DsStatusPillTone.neutral,
          ),
          const SizedBox(width: KeenaiSpacing.space8),
        ],
        if (showValue && (valueText?.isNotEmpty ?? false))
          Text(
            valueText!,
            style: KeenaiTypographyBody.body12Medium
                .copyWith(color: KeenaiColorsText.muted),
          ),
      ],
    );
  }
}

class _TrailingBlock extends StatelessWidget {
  const _TrailingBlock({
    required this.trailing,
    required this.showChevron,
    required this.trailingPrimaryValue,
    required this.trailingCurrency,
    required this.trailingSecondaryValue,
    required this.trailingSingleLine,
  });

  final DsAssetListItemTrailing trailing;
  final bool showChevron;
  final String trailingPrimaryValue;
  final String trailingCurrency;
  final String trailingSecondaryValue;
  final String trailingSingleLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: trailing == DsAssetListItemTrailing.sub
              ? [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        trailingPrimaryValue,
                        style: KeenaiTypographyBody.body14Semibold
                            .copyWith(color: KeenaiColorsText.main),
                      ),
                      const SizedBox(width: KeenaiSpacing.space4),
                      Text(
                        trailingCurrency,
                        style: KeenaiTypographyBody.body10Semibold
                            .copyWith(color: KeenaiColorsText.muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: KeenaiSpacing.space4),
                  Text(
                    trailingSecondaryValue,
                    style: KeenaiTypographyBody.body12Regular
                        .copyWith(color: KeenaiColorsText.muted),
                  ),
                ]
              : [
                  Text(
                    trailingSingleLine,
                    style: KeenaiTypographyBody.body14Semibold
                        .copyWith(color: KeenaiColorsText.main),
                  ),
                ],
        ),
        if (showChevron) ...[
          const SizedBox(width: KeenaiSpacing.space8),
          const _DsChevronRight(),
        ],
      ],
    );
  }
}

/// 20×20 chevron — Figma `41:68` (vector, no Material icon font).
class _DsChevronRight extends StatelessWidget {
  const _DsChevronRight();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.square(KeenaiSpacing.space20),
      painter: _ChevronRightPainter(color: KeenaiColorsText.muted),
    );
  }
}

class _ChevronRightPainter extends CustomPainter {
  _ChevronRightPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(7.5, 5)
      ..lineTo(12.5, 10)
      ..lineTo(7.5, 15);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ChevronRightPainter oldDelegate) =>
      oldDelegate.color != color;
}
