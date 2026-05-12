import 'package:flutter/material.dart' show Icon, Icons;
import 'package:flutter/widgets.dart';

import 'tokens.dart';

/// Visual variant for [DsChip] — Figma node `47:2` (Chips).
enum DsChipVariant {
  /// Solid primary background, white label (e.g. "All").
  selected,

  /// White surface, light border, muted label; optional chevron.
  outlined,

  /// Surface fill, strong border, check + primary label (multi-select).
  multiSelect,
}

/// Pill-shaped filter chip — Figma `47:2` (DS-Web-to-Figma / Chips).
///
/// Uses only the widgets layer (no Material / Cupertino). Leading icons use
/// [Icon] so the component stays self-contained in git (no remote asset URLs).
class DsChip extends StatelessWidget {
  const DsChip({
    super.key,
    required this.label,
    this.variant = DsChipVariant.selected,
    this.showLeadingIcon = true,
  });

  final String label;
  final DsChipVariant variant;
  final bool showLeadingIcon;

  static const double _iconSize = 16;
  static const double _gap = 4;

  EdgeInsets get _padding =>
      const EdgeInsets.symmetric(horizontal: 8, vertical: 6);

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color? border, TextStyle textStyle) = switch (variant) {
      DsChipVariant.selected => (
          DsColors.textMain,
          null,
          DsTypography.chipLabelMedium.copyWith(color: DsColors.surfaceWhite),
        ),
      DsChipVariant.outlined => (
          DsColors.surfaceWhite,
          DsColors.borderLight,
          DsTypography.chipLabelRegular.copyWith(color: DsColors.textMuted),
        ),
      DsChipVariant.multiSelect => (
          DsColors.surfaceBg,
          DsColors.borderStrong,
          DsTypography.chipLabelMedium.copyWith(color: DsColors.textMain),
        ),
    };

    final List<Widget> children = [];

    if (variant == DsChipVariant.outlined && showLeadingIcon) {
      children.addAll([
        Icon(
          Icons.expand_more_rounded,
          size: _iconSize,
          color: DsColors.textMuted,
        ),
        const SizedBox(width: _gap),
      ]);
    } else if (variant == DsChipVariant.multiSelect) {
      children.addAll([
        Icon(
          Icons.check_rounded,
          size: _iconSize,
          color: DsColors.textMain,
        ),
        const SizedBox(width: _gap),
      ]);
    }

    children.add(
      Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textStyle,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(1000),
        border: border != null
            ? Border.all(color: border, width: 1)
            : null,
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
