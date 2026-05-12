import 'package:flutter/painting.dart';

import '../tokens/tokens.dart';

/// Legacy semantic aliases — values match `tokens.json` via [KeenaiColorsText],
/// [KeenaiColorsBorder], etc.
abstract final class DsColors {
  static const Color textMain = KeenaiColorsText.main;
  static const Color textMuted = KeenaiColorsText.muted;
  static const Color textGreen = KeenaiColorsText.green;
  static const Color textRed = KeenaiColorsText.red;

  static const Color surfacePink = KeenaiColorsSurface.pink;
  static const Color surfaceTeal = KeenaiColorsSurface.teal;
  static const Color surfaceBg = KeenaiColorsSurface.bg;

  static const Color borderLight = KeenaiColorsBorder.light;
  static const Color borderStrong = KeenaiColorsBorder.strong;

  static const Color surfaceWhite = KeenaiColorsSurface.white;

  static const Color bannerInfoBg = KeenaiColorsSurface.card;
  static const Color bannerWarningBg = KeenaiColorsBanner.warningBg;
  static const Color bannerSuccessBg = KeenaiColorsBanner.successBg;
  static const Color bannerDangerBg = KeenaiColorsBanner.dangerBg;

  static const Color bannerWarningBorder = KeenaiColorsBanner.warningBorder;
  static const Color bannerSuccessBorder = KeenaiColorsBanner.successBorder;
  static const Color bannerDangerBorder = KeenaiColorsBanner.dangerBorder;

  static const Color bannerWarningText = KeenaiColorsBanner.warningText;
  static const Color bannerSuccessText = KeenaiColorsBanner.successText;
  static const Color bannerDangerText = KeenaiColorsBanner.dangerText;
}

/// Legacy semantic text styles — built from [KeenaiTypographyBody] / [KeenaiTypographyDisplay].
abstract final class DsTypography {
  static TextStyle get t12 => KeenaiTypographyBody.body12Regular.copyWith(
        color: KeenaiColorsText.main,
      );

  static TextStyle get t14Value => KeenaiTypographyBody.body14Medium.copyWith(
        color: KeenaiColorsText.main,
      );

  static TextStyle get t16Value => KeenaiTypographyBody.body16Semibold.copyWith(
        color: KeenaiColorsText.main,
      );

  static TextStyle get t26Value => KeenaiTypographyDisplay.display26Medium.copyWith(
        color: KeenaiColorsText.main,
      );

  static TextStyle labelMuted(TextStyle base) =>
      base.copyWith(color: KeenaiColorsText.muted);

  static TextStyle get statusPillMd => KeenaiTypographyBody.body12Medium;

  static TextStyle get statusPillSm => KeenaiTypographyBody.body10Semibold;

  static TextStyle get assetListTitle => KeenaiTypographyBody.body14Medium.copyWith(
        color: KeenaiColorsText.main,
      );

  static TextStyle get assetListBodyMuted =>
      KeenaiTypographyBody.body12Regular.copyWith(
        color: KeenaiColorsText.muted,
      );

  static TextStyle get chipLabelMedium => KeenaiTypographyBody.body12Medium;

  static TextStyle get chipLabelRegular => KeenaiTypographyBody.body12Regular;

  static TextStyle get assetListMetaMuted => KeenaiTypographyBody.body12Medium.copyWith(
        color: KeenaiColorsText.muted,
      );

  static TextStyle get assetListValueBold => KeenaiTypographyBody.body14Semibold.copyWith(
        color: KeenaiColorsText.main,
      );

  static TextStyle get assetListCurrency => KeenaiTypographyBody.body10Semibold.copyWith(
        color: KeenaiColorsText.muted,
      );

  static TextStyle infoBannerBody(Color color) =>
      KeenaiTypographyBody.body14Regular.copyWith(color: color);
}
