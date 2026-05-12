import 'package:flutter/widgets.dart';

import 'tokens.dart';

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
        return DsColors.surfacePink;
      case DsStatusPillTone.success:
        return DsColors.surfaceTeal;
      case DsStatusPillTone.neutral:
        return DsColors.surfaceBg;
    }
  }

  Color get _foreground {
    switch (tone) {
      case DsStatusPillTone.danger:
        return DsColors.textRed;
      case DsStatusPillTone.success:
        return DsColors.textGreen;
      case DsStatusPillTone.neutral:
        return DsColors.textMuted;
    }
  }

  TextStyle get _textStyle {
    final base = size == DsStatusPillSize.md
        ? DsTypography.statusPillMd
        : DsTypography.statusPillSm;
    return base.copyWith(color: _foreground);
  }

  EdgeInsets get _padding {
    switch (size) {
      case DsStatusPillSize.md:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 6);
      case DsStatusPillSize.sm:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(1000),
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
