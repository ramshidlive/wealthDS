import 'package:keenai_ds/components/stat_box.dart';

import '../knobs/knob.dart';
import '_code_utils.dart';
import 'showcase.dart';

final statBoxShowcase = ComponentShowcase(
  id: 'stat_box',
  name: 'StatBox',
  description: 'Column of label, primary value, and an optional supporting '
      'line — three sizes and start/center/end alignment.',
  knobs: [
    KnobSpec.text(id: 'label', label: 'label', initial: 'Trade date'),
    KnobSpec.text(id: 'value', label: 'value', initial: "09 Apr '26"),
    KnobSpec.toggle(
      id: 'showSupporting',
      label: 'supporting line',
      description: 'When off, supportingText & supportingLeadingLabel are null',
      initial: true,
    ),
    KnobSpec.text(
      id: 'supportingText',
      label: 'supportingText',
      initial: 'Monthly',
      enabledWhen: 'showSupporting',
    ),
    KnobSpec.text(
      id: 'supportingLeadingLabel',
      label: 'supportingLeadingLabel',
      initial: 'Freq: ',
      enabledWhen: 'showSupporting',
    ),
    KnobSpec.dropdown(
      id: 'size',
      label: 'size',
      initial: DsStatBoxSize.small,
      options: [
        for (final s in DsStatBoxSize.values)
          KnobOption(s, s.name, code: 'DsStatBoxSize.${s.name}'),
      ],
    ),
    KnobSpec.dropdown(
      id: 'alignment',
      label: 'alignment',
      initial: DsStatBoxAlignment.start,
      options: [
        for (final a in DsStatBoxAlignment.values)
          KnobOption(a, a.name, code: 'DsStatBoxAlignment.${a.name}'),
      ],
    ),
  ],
  build: (values) {
    final showSupporting = values.get<bool>('showSupporting');
    final leadingRaw = values.get<String>('supportingLeadingLabel');
    return DsStatBox(
      label: values.get<String>('label'),
      value: values.get<String>('value'),
      supportingText:
          showSupporting ? values.get<String>('supportingText') : null,
      supportingLeadingLabel:
          showSupporting && leadingRaw.isNotEmpty ? leadingRaw : null,
      size: values.get<DsStatBoxSize>('size'),
      alignment: values.get<DsStatBoxAlignment>('alignment'),
    );
  },
  codeFor: (values) {
    final showSupporting = values.get<bool>('showSupporting');
    final leadingRaw = values.get<String>('supportingLeadingLabel');
    final size = values.get<DsStatBoxSize>('size');
    final align = values.get<DsStatBoxAlignment>('alignment');
    return 'DsStatBox(\n'
        '${arg('label', str(values.get<String>('label')))}'
        '${arg('value', str(values.get<String>('value')))}'
        '${nullableStr('supportingText', showSupporting ? values.get<String>('supportingText') : null, include: true)}'
        '${nullableStr('supportingLeadingLabel', showSupporting && leadingRaw.isNotEmpty ? leadingRaw : null, include: true)}'
        '${arg('size', 'DsStatBoxSize.${size.name}')}'
        '${arg('alignment', 'DsStatBoxAlignment.${align.name}')}'
        ')';
  },
);
