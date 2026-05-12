import 'package:flutter/painting.dart';

/// JSON `colors.text`.
abstract final class KeenaiColorsText {
  static const Color main = Color(0xFF111E2E);
  static const Color muted = Color(0xFF828A96);
  static const Color green = Color(0xFF04B08D);
  static const Color red = Color(0xFFE31937);
}

/// JSON `colors.border`.
abstract final class KeenaiColorsBorder {
  static const Color strong = Color(0xFFCED1D9);
  static const Color medium = Color(0xFFE7E8EC);
  static const Color light = Color(0xFFEBEDF0);
}

/// JSON `colors.surface`.
abstract final class KeenaiColorsSurface {
  static const Color white = Color(0xFFFFFFFF);
  static const Color bg = Color(0xFFF5F6F7);
  static const Color card = Color(0xFFFAFBFC);
  static const Color pink = Color(0xFFFEF6F7);
  static const Color teal = Color(0xFFEBF9F6);
}

/// JSON `colors.banner`.
abstract final class KeenaiColorsBanner {
  static const Color warningBg = Color(0xFFFFF8EC);
  static const Color warningBorder = Color(0xFFF2D49F);
  static const Color warningText = Color(0xFF9A6506);
  static const Color successBg = Color(0xFFEFFBF6);
  static const Color successBorder = Color(0xFFBCE8DA);
  static const Color successText = Color(0xFF0F7E63);
  static const Color dangerBg = Color(0xFFFFF4F6);
  static const Color dangerBorder = Color(0xFFF6C8D1);
  static const Color dangerText = Color(0xFFB8132D);
}

/// Color tokens from `tokens.json` → `colors`.
///
/// Subgroups match the JSON object: [KeenaiColorsText], [KeenaiColorsBorder],
/// [KeenaiColorsSurface], [KeenaiColorsBanner].
abstract final class KeenaiColors {
  const KeenaiColors._();
}
