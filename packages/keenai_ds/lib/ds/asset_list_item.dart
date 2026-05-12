import 'package:flutter/widgets.dart';

import 'status_pill.dart';
import 'tokens.dart';

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
    this.showStatusPill = false,
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
  final bool showStatusPill;
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
      showOrderType || showStatusPill || (showValue && (valueText?.isNotEmpty ?? false));

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: DsColors.borderLight, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
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
                      trailing: trailing,
                      titleMaxLines: titleMaxLines,
                    ),
                    if (_hasMetaRow) ...[
                      const SizedBox(height: 4),
                      _MetaRow(
                        showOrderType: showOrderType,
                        showStatusPill: showStatusPill,
                        showValue: showValue,
                        valueText: valueText,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 32),
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
    required this.trailing,
    required this.titleMaxLines,
  });

  final String title;
  final String assetTagLabel;
  final bool showAssetTag;
  final DsAssetListItemTrailing trailing;
  final int titleMaxLines;

  @override
  Widget build(BuildContext context) {
    final titleText = Text(
      title,
      maxLines: titleMaxLines,
      overflow:
          titleMaxLines > 1 ? TextOverflow.visible : TextOverflow.ellipsis,
      style: DsTypography.assetListTitle,
    );

    if (!showAssetTag) {
      return titleText;
    }

    final tag = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: DsColors.textMuted,
            shape: BoxShape.circle,
          ),
          child: const SizedBox(width: 2, height: 2),
        ),
        const SizedBox(width: 6),
        Text(
          assetTagLabel,
          style: DsTypography.assetListBodyMuted,
        ),
      ],
    );

    if (trailing == DsAssetListItemTrailing.single) {
      return Row(
        children: [
          Expanded(child: titleText),
          const SizedBox(width: 6),
          tag,
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        titleText,
        const SizedBox(width: 6),
        tag,
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.showOrderType,
    required this.showStatusPill,
    required this.showValue,
    required this.valueText,
  });

  final bool showOrderType;
  final bool showStatusPill;
  final bool showValue;
  final String? valueText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showOrderType) ...[
          const DsStatusPill(
            label: 'S',
            size: DsStatusPillSize.sm,
            tone: DsStatusPillTone.danger,
          ),
          const SizedBox(width: 8),
        ],
        if (showStatusPill) ...[
          const DsStatusPill(
            label: 'FAILED',
            size: DsStatusPillSize.sm,
            tone: DsStatusPillTone.neutral,
          ),
          const SizedBox(width: 8),
        ],
        if (showValue && (valueText?.isNotEmpty ?? false))
          Text(
            valueText!,
            style: DsTypography.assetListMetaMuted,
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
                        style: DsTypography.assetListValueBold,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        trailingCurrency,
                        style: DsTypography.assetListCurrency,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trailingSecondaryValue,
                    style: DsTypography.assetListBodyMuted,
                  ),
                ]
              : [
                  Text(
                    trailingSingleLine,
                    style: DsTypography.assetListValueBold,
                  ),
                ],
        ),
        if (showChevron) ...[
          const SizedBox(width: 8),
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
      size: const Size(20, 20),
      painter: _ChevronRightPainter(color: DsColors.textMuted),
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
