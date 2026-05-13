import 'package:keenai_ds/components/status_pill.dart';

import '../knobs/knob.dart';
import '_code_utils.dart';
import 'showcase.dart';

final statusPillShowcase = ComponentShowcase(
  id: 'status_pill',
  name: 'StatusPill',
  description: 'Pill-shaped status label in danger / success / neutral tones, '
      'sm or md.',
  knobs: [
    KnobSpec.text(id: 'label', label: 'label', initial: 'KI Breached'),
    KnobSpec.dropdown(
      id: 'size',
      label: 'size',
      initial: DsStatusPillSize.md,
      options: [
        for (final s in DsStatusPillSize.values)
          KnobOption(s, s.name, code: 'DsStatusPillSize.${s.name}'),
      ],
    ),
    KnobSpec.dropdown(
      id: 'tone',
      label: 'tone',
      initial: DsStatusPillTone.danger,
      options: [
        for (final t in DsStatusPillTone.values)
          KnobOption(t, t.name, code: 'DsStatusPillTone.${t.name}'),
      ],
    ),
  ],
  build: (values) => DsStatusPill(
    label: values.get<String>('label'),
    size: values.get<DsStatusPillSize>('size'),
    tone: values.get<DsStatusPillTone>('tone'),
  ),
  codeFor: (values) {
    final size = values.get<DsStatusPillSize>('size');
    final tone = values.get<DsStatusPillTone>('tone');
    return 'DsStatusPill(\n'
        '${arg('label', str(values.get<String>('label')))}'
        '${arg('size', 'DsStatusPillSize.${size.name}')}'
        '${arg('tone', 'DsStatusPillTone.${tone.name}')}'
        ')';
  },
);
