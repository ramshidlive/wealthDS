import 'package:flutter/widgets.dart';

import 'tokens.dart';

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
        return DsTypography.t14Value;
      case DsStatBoxSize.medium:
        return DsTypography.t16Value;
      case DsStatBoxSize.large:
        return DsTypography.t26Value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = DsTypography.labelMuted(DsTypography.t12);
    final supportingBodyStyle = DsTypography.t12;
    final supportingLabelStyle = DsTypography.labelMuted(DsTypography.t12);

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
        const SizedBox(height: 2),
        Text(
          value,
          textAlign: _textAlign,
          style: _valueStyle,
        ),
        if (showSupporting) ...[
          const SizedBox(height: 6),
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
