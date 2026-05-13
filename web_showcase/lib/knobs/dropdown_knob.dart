import 'package:flutter/material.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../theme/showcase_theme.dart';
import '_label.dart';
import 'knob.dart';

class DropdownKnob extends StatelessWidget {
  const DropdownKnob({
    super.key,
    required this.spec,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final KnobSpec spec;
  final Object value;
  final ValueChanged<Object> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    final disabled = !enabled;
    final fillColor = disabled ? c.card : c.surface;
    final textColor = disabled ? c.muted : c.text;
    return Opacity(
      opacity: disabled ? 0.55 : 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KnobLabel(spec: spec),
          const SizedBox(height: KeenaiSpacing.space6),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: KeenaiSpacing.space12,
            ),
            decoration: BoxDecoration(
              color: fillColor,
              border: Border.all(color: c.border),
              borderRadius: BorderRadius.circular(KeenaiRadius.radius8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Object>(
                value: value,
                isExpanded: true,
                dropdownColor: c.surface,
                style: KeenaiTypographyBody.body14Regular
                    .copyWith(color: textColor),
                items: [
                  for (final opt in spec.options)
                    DropdownMenuItem<Object>(
                      value: opt.value,
                      child: Text(opt.label),
                    ),
                ],
                onChanged: enabled
                    ? (v) {
                        if (v != null) onChanged(v);
                      }
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
