import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';

/// Horizontal alignment of label, value, and supporting text.
enum DsStatBoxAlignment {
  start,
  center,
  end,
}

/// Value typography scale (`.statBox--small|medium|large` in `styles.css`).
enum DsStatBoxSize {
  small,
  medium,
  large,
}

/// StatBox — column of label, primary value, and optional supporting line.
///
/// Spec: `.statBox` in Wealth `styles.css` (DS Web → Figma parity).
/// Uses only the widgets layer (no Material / Cupertino).
class DsStatBox extends StatelessWidget {
  const DsStatBox({
    super.key,
    required this.label,
    required this.value,
    this.supportingText,
    this.supportingLeadingLabel,
    this.size = DsStatBoxSize.small,
    this.alignment = DsStatBoxAlignment.start,
  });

  final String label;
  final String value;
  final String? supportingText;
  /// Muted prefix before [supportingText], e.g. `"Freq: "`.
  final String? supportingLeadingLabel;
  final DsStatBoxSize size;
  final DsStatBoxAlignment alignment;

  CrossAxisAlignment get _crossAxisAlignment {
    switch (alignment) {
      case DsStatBoxAlignment.start:
        return CrossAxisAlignment.start;
      case DsStatBoxAlignment.center:
        return CrossAxisAlignment.center;
      case DsStatBoxAlignment.end:
        return CrossAxisAlignment.end;
    }
  }

  TextAlign get _textAlign {
    switch (alignment) {
      case DsStatBoxAlignment.start:
        return TextAlign.start;
      case DsStatBoxAlignment.center:
        return TextAlign.center;
      case DsStatBoxAlignment.end:
        return TextAlign.end;
    }
  }

  TextStyle get _valueStyle {
    switch (size) {
      case DsStatBoxSize.small:
        return KeenaiTypographyBody.body14Medium
            .copyWith(color: KeenaiColorsText.main);
      case DsStatBoxSize.medium:
        return KeenaiTypographyBody.body16Semibold
            .copyWith(color: KeenaiColorsText.main);
      case DsStatBoxSize.large:
        return KeenaiTypographyDisplay.display26Medium
            .copyWith(color: KeenaiColorsText.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle =
        KeenaiTypographyBody.body12Regular.copyWith(color: KeenaiColorsText.muted);
    final supportingBodyStyle = KeenaiTypographyBody.body12Regular;
    final supportingLabelStyle =
        KeenaiTypographyBody.body12Regular.copyWith(color: KeenaiColorsText.muted);

    final showSupporting =
        supportingText != null && supportingText!.isNotEmpty;

    return Column(
      crossAxisAlignment: _crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          textAlign: _textAlign,
          style: labelStyle,
        ),
        SizedBox(height: KeenaiSpacing.space2),
        Text(
          value,
          textAlign: _textAlign,
          style: _valueStyle,
        ),
        if (showSupporting) ...[
          SizedBox(height: KeenaiSpacing.space6),
          Text.rich(
            TextSpan(
              style: supportingBodyStyle,
              children: [
                if (supportingLeadingLabel != null &&
                    supportingLeadingLabel!.isNotEmpty)
                  TextSpan(
                    text: supportingLeadingLabel,
                    style: supportingLabelStyle,
                  ),
                TextSpan(text: supportingText),
              ],
            ),
            textAlign: _textAlign,
          ),
        ],
      ],
    );
  }
}
