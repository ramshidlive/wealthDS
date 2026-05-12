import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';

/// Figma `StatusPill` size variants (MD / SM).
enum DsStatusPillSize {
  md,
  sm,
}

/// Figma `StatusPill` tone variants.
enum DsStatusPillTone {
  danger,
  success,
  neutral,
}

/// Pill-shaped status label — Figma node `9:14` (StatusPill).
///
/// Uses only the widgets layer (no Material / Cupertino).
class DsStatusPill extends StatelessWidget {
  const DsStatusPill({
    super.key,
    required this.label,
    this.size = DsStatusPillSize.md,
    this.tone = DsStatusPillTone.danger,
  });

  final String label;
  final DsStatusPillSize size;
  final DsStatusPillTone tone;

  Color get _background {
    switch (tone) {
      case DsStatusPillTone.danger:
        return KeenaiColorsSurface.pink;
      case DsStatusPillTone.success:
        return KeenaiColorsSurface.teal;
      case DsStatusPillTone.neutral:
        return KeenaiColorsSurface.bg;
    }
  }

  Color get _foreground {
    switch (tone) {
      case DsStatusPillTone.danger:
        return KeenaiColorsText.red;
      case DsStatusPillTone.success:
        return KeenaiColorsText.green;
      case DsStatusPillTone.neutral:
        return KeenaiColorsText.muted;
    }
  }

  TextStyle get _textStyle {
    final base = size == DsStatusPillSize.md
        ? KeenaiTypographyBody.body12Medium
        : KeenaiTypographyBody.body10Semibold;
    return base.copyWith(color: _foreground);
  }

  EdgeInsets get _padding {
    switch (size) {
      case DsStatusPillSize.md:
        return const EdgeInsets.symmetric(
          horizontal: KeenaiSpacing.space8,
          vertical: KeenaiSpacing.space6,
        );
      case DsStatusPillSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: KeenaiSpacing.space8,
          vertical: KeenaiSpacing.space4,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(KeenaiRadius.radius1000),
      ),
      child: Padding(
        padding: _padding,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: _textStyle,
        ),
      ),
    );
  }
}
