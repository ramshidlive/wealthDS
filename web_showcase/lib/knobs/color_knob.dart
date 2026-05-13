import 'package:flutter/material.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../theme/showcase_theme.dart';
import '_label.dart';
import 'knob.dart';

/// Token-based color picker. The swatches are *all* the colors that the
/// design system exposes — picking one returns its `Color` value.
class ColorKnob extends StatelessWidget {
  const ColorKnob({
    super.key,
    required this.spec,
    required this.value,
    required this.onChanged,
  });

  final KnobSpec spec;
  final Color value;
  final ValueChanged<Color> onChanged;

  static const _swatches = <_Swatch>[
    _Swatch('text.main', KeenaiColorsText.main),
    _Swatch('text.muted', KeenaiColorsText.muted),
    _Swatch('text.green', KeenaiColorsText.green),
    _Swatch('text.red', KeenaiColorsText.red),
    _Swatch('surface.white', KeenaiColorsSurface.white),
    _Swatch('surface.card', KeenaiColorsSurface.card),
    _Swatch('surface.bg', KeenaiColorsSurface.bg),
    _Swatch('surface.pink', KeenaiColorsSurface.pink),
    _Swatch('surface.teal', KeenaiColorsSurface.teal),
    _Swatch('border.strong', KeenaiColorsBorder.strong),
    _Swatch('border.medium', KeenaiColorsBorder.medium),
    _Swatch('border.light', KeenaiColorsBorder.light),
  ];

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KnobLabel(spec: spec),
        const SizedBox(height: KeenaiSpacing.space6),
        Wrap(
          spacing: KeenaiSpacing.space6,
          runSpacing: KeenaiSpacing.space6,
          children: [
            for (final s in _swatches)
              Tooltip(
                message: s.name,
                child: GestureDetector(
                  onTap: () => onChanged(s.color),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: s.color,
                      borderRadius:
                          BorderRadius.circular(KeenaiRadius.radius4),
                      border: Border.all(
                        color: s.color.value == value.value
                            ? KeenaiColorsText.green
                            : c.border,
                        width: s.color.value == value.value ? 2 : 1,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _Swatch {
  const _Swatch(this.name, this.color);
  final String name;
  final Color color;
}
