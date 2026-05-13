import 'package:flutter/material.dart';
import 'package:keenai_ds/tokens/tokens.dart';

/// App-chrome theme built from keenai_ds tokens. The showcased components
/// themselves never read from this — they consume tokens directly.
class ShowcaseTheme {
  static ThemeData light() => _build(
        brightness: Brightness.light,
        background: KeenaiColorsSurface.bg,
        surface: KeenaiColorsSurface.white,
        card: KeenaiColorsSurface.card,
        border: KeenaiColorsBorder.medium,
        text: KeenaiColorsText.main,
        muted: KeenaiColorsText.muted,
      );

  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        background: const Color(0xFF0E1320),
        surface: const Color(0xFF161C2C),
        card: const Color(0xFF1C2336),
        border: const Color(0xFF2A3247),
        text: const Color(0xFFEAECEF),
        muted: const Color(0xFF9098A5),
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color card,
    required Color border,
    required Color text,
    required Color muted,
  }) {
    final base = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      canvasColor: surface,
      cardColor: card,
      dividerColor: border,
      colorScheme: ColorScheme.fromSeed(
        seedColor: KeenaiColorsText.green,
        brightness: brightness,
        surface: surface,
        onSurface: text,
      ),
      fontFamily: 'Geist',
      textTheme: const TextTheme().apply(
        bodyColor: text,
        displayColor: text,
      ),
    );
    return base.copyWith(
      extensions: [
        ShowcaseColors(
          background: background,
          surface: surface,
          card: card,
          border: border,
          text: text,
          muted: muted,
        ),
      ],
    );
  }
}

@immutable
class ShowcaseColors extends ThemeExtension<ShowcaseColors> {
  const ShowcaseColors({
    required this.background,
    required this.surface,
    required this.card,
    required this.border,
    required this.text,
    required this.muted,
  });

  final Color background;
  final Color surface;
  final Color card;
  final Color border;
  final Color text;
  final Color muted;

  @override
  ShowcaseColors copyWith({
    Color? background,
    Color? surface,
    Color? card,
    Color? border,
    Color? text,
    Color? muted,
  }) =>
      ShowcaseColors(
        background: background ?? this.background,
        surface: surface ?? this.surface,
        card: card ?? this.card,
        border: border ?? this.border,
        text: text ?? this.text,
        muted: muted ?? this.muted,
      );

  @override
  ShowcaseColors lerp(ShowcaseColors? other, double t) {
    if (other == null) return this;
    return ShowcaseColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      border: Color.lerp(border, other.border, t)!,
      text: Color.lerp(text, other.text, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
    );
  }

  static ShowcaseColors of(BuildContext context) =>
      Theme.of(context).extension<ShowcaseColors>()!;
}
