import 'package:flutter/material.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../theme/showcase_theme.dart';
import '_label.dart';
import 'knob.dart';

class SliderKnob extends StatelessWidget {
  const SliderKnob({
    super.key,
    required this.spec,
    required this.value,
    required this.onChanged,
  });

  final KnobSpec spec;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    final divisions = ((spec.max - spec.min) / spec.step).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: KnobLabel(spec: spec)),
            Text(
              value.toStringAsFixed(spec.step >= 1 ? 0 : 2),
              style:
                  KeenaiTypographyBody.body12Regular.copyWith(color: c.muted),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: KeenaiColorsText.green,
            thumbColor: KeenaiColorsText.green,
            inactiveTrackColor: c.border,
            trackHeight: 3,
          ),
          child: Slider(
            value: value.clamp(spec.min, spec.max),
            min: spec.min,
            max: spec.max,
            divisions: divisions > 0 ? divisions : null,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
