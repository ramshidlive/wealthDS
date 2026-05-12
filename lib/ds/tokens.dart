import 'package:flutter/painting.dart';

/// Design tokens aligned with Wealth mobile `styles.css` (:root).
abstract final class DsColors {
  static const Color textMain = Color(0xFF111E2E);
  static const Color textMuted = Color(0xFF828A96);
  static const Color textGreen = Color(0xFF04B08D);
  static const Color textRed = Color(0xFFE31937);

  /// Surfaces for StatusPill (Figma / `styles.css` tokens).
  static const Color surfacePink = Color(0xFFFEF6F7);
  static const Color surfaceTeal = Color(0xFFEBF9F6);
  static const Color surfaceBg = Color(0xFFF5F6F7);

  /// Dividers / list borders (Figma `--border/light`).
  static const Color borderLight = Color(0xFFEBEDF0);
}

abstract final class DsTypography {
  /// 12 / 16 — labels, supporting body.
  static TextStyle get t12 => const TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w400,
        color: DsColors.textMain,
      );

  /// 14 / 20 — StatBox small value.
  static TextStyle get t14Value => TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        color: DsColors.textMain,
        letterSpacing: -0.0125 * 14,
      );

  /// 16 / 22 — StatBox medium value.
  static TextStyle get t16Value => TextStyle(
        fontSize: 16,
        height: 22 / 16,
        fontWeight: FontWeight.w600,
        color: DsColors.textMain,
        letterSpacing: -0.0125 * 16,
      );

  /// 26 / 32 — StatBox large value.
  static TextStyle get t26Value => TextStyle(
        fontSize: 26,
        height: 32 / 26,
        fontWeight: FontWeight.w500,
        color: DsColors.textMain,
        letterSpacing: -0.012 * 26,
      );

  static TextStyle labelMuted(TextStyle base) =>
      base.copyWith(color: DsColors.textMuted);

  /// StatusPill MD — Body/12 Medium (Figma node 9:14).
  static TextStyle get statusPillMd => const TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
      );

  /// StatusPill SM — Body/10 SemiBold.
  static TextStyle get statusPillSm => const TextStyle(
        fontSize: 10,
        height: 14 / 10,
        fontWeight: FontWeight.w600,
      );

  /// AssetListItem title — Body/14 Medium (Figma `41:98`).
  static TextStyle get assetListTitle => const TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        color: DsColors.textMain,
        letterSpacing: -0.196,
      );

  /// Asset tag / secondary line — Body/12 Regular muted.
  static TextStyle get assetListBodyMuted => const TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w400,
        color: DsColors.textMuted,
      );

  /// Meta quantity — Body/12 Medium muted.
  static TextStyle get assetListMetaMuted => const TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
        color: DsColors.textMuted,
      );

  /// Trailing primary value — Body/14 SemiBold.
  static TextStyle get assetListValueBold => const TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w600,
        color: DsColors.textMain,
        letterSpacing: -0.196,
      );

  /// Trailing currency — 10 SemiBold muted.
  static TextStyle get assetListCurrency => const TextStyle(
        fontSize: 10,
        height: 14 / 10,
        fontWeight: FontWeight.w600,
        color: DsColors.textMuted,
      );
}
