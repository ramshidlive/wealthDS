import 'package:flutter/material.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '_label.dart';
import 'knob.dart';

class ToggleKnob extends StatelessWidget {
  const ToggleKnob({
    super.key,
    required this.spec,
    required this.value,
    required this.onChanged,
  });

  final KnobSpec spec;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: KnobLabel(spec: spec)),
        const SizedBox(width: KeenaiSpacing.space12),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: KeenaiColorsText.green,
        ),
      ],
    );
  }
}
