import 'package:flutter/material.dart' show Icon, Icons;
import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';

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

  static const double _iconSize = KeenaiSpacing.space16;
  static const double _gap = KeenaiSpacing.space4;

  EdgeInsets get _padding => const EdgeInsets.symmetric(
        horizontal: KeenaiSpacing.space8,
        vertical: KeenaiSpacing.space6,
      );

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color? border, TextStyle textStyle) = switch (variant) {
      DsChipVariant.selected => (
          KeenaiColorsText.main,
          null,
          KeenaiTypographyBody.body12Medium
              .copyWith(color: KeenaiColorsSurface.white),
        ),
      DsChipVariant.outlined => (
          KeenaiColorsSurface.white,
          KeenaiColorsBorder.light,
          KeenaiTypographyBody.body12Regular
              .copyWith(color: KeenaiColorsText.muted),
        ),
      DsChipVariant.multiSelect => (
          KeenaiColorsSurface.bg,
          KeenaiColorsBorder.strong,
          KeenaiTypographyBody.body12Medium
              .copyWith(color: KeenaiColorsText.main),
        ),
    };

    final List<Widget> children = [];

    if (variant == DsChipVariant.outlined && showLeadingIcon) {
      children.addAll([
        Icon(
          Icons.expand_more_rounded,
          size: _iconSize,
          color: KeenaiColorsText.muted,
        ),
        const SizedBox(width: _gap),
      ]);
    } else if (variant == DsChipVariant.multiSelect) {
      children.addAll([
        Icon(
          Icons.check_rounded,
          size: _iconSize,
          color: KeenaiColorsText.main,
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
        borderRadius: BorderRadius.circular(KeenaiRadius.radius1000),
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
