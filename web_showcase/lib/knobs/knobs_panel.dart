import 'package:flutter/material.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../theme/showcase_theme.dart';
import 'color_knob.dart';
import 'dropdown_knob.dart';
import 'knob.dart';
import 'slider_knob.dart';
import 'text_knob.dart';
import 'toggle_knob.dart';

class KnobsPanel extends StatelessWidget {
  const KnobsPanel({
    super.key,
    required this.specs,
    required this.values,
    required this.onChanged,
  });

  final List<KnobSpec> specs;
  final KnobValues values;
  final void Function(String id, Object value) onChanged;

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(left: BorderSide(color: c.border)),
      ),
      child: ListView(
        padding: const EdgeInsets.all(KeenaiSpacing.space20),
        children: [
          Text(
            'Knobs',
            style: KeenaiTypographyBody.body16Semibold.copyWith(color: c.text),
          ),
          const SizedBox(height: KeenaiSpacing.space4),
          Text(
            'Tune the live preview',
            style: KeenaiTypographyBody.body12Regular.copyWith(color: c.muted),
          ),
          const SizedBox(height: KeenaiSpacing.space20),
          for (final spec in specs) ...[
            _buildKnob(spec),
            const SizedBox(height: KeenaiSpacing.space16),
          ],
        ],
      ),
    );
  }

  bool _enabled(KnobSpec spec) {
    final gate = spec.enabledWhen;
    if (gate == null) return true;
    return values.get<bool>(gate);
  }

  Widget _buildKnob(KnobSpec spec) {
    switch (spec.type) {
      case KnobType.text:
        return TextKnob(
          spec: spec,
          value: values.get<String>(spec.id),
          enabled: _enabled(spec),
          onChanged: (v) => onChanged(spec.id, v),
        );
      case KnobType.dropdown:
        return DropdownKnob(
          spec: spec,
          value: values.raw(spec.id)!,
          enabled: _enabled(spec),
          onChanged: (v) => onChanged(spec.id, v),
        );
      case KnobType.toggle:
        return ToggleKnob(
          spec: spec,
          value: values.get<bool>(spec.id),
          onChanged: (v) => onChanged(spec.id, v),
        );
      case KnobType.slider:
        return SliderKnob(
          spec: spec,
          value: values.get<double>(spec.id),
          onChanged: (v) => onChanged(spec.id, v),
        );
      case KnobType.color:
        return ColorKnob(
          spec: spec,
          value: values.get<Color>(spec.id),
          onChanged: (v) => onChanged(spec.id, v),
        );
    }
  }
}
