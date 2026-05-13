import 'package:flutter/widgets.dart';
import 'package:keenai_ds/components/key_value_row.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../knobs/knob.dart';
import '_code_utils.dart';
import 'showcase.dart';

final keyValueRowShowcase = ComponentShowcase(
  id: 'key_value_row',
  name: 'KeyValueRow',
  description: 'Single key/value row with optional info, chevron, and divider '
      '— regular or dense density.',
  knobs: [
    KnobSpec.text(id: 'label', label: 'label', initial: 'Coupon Frequency'),
    KnobSpec.text(id: 'value', label: 'value', initial: 'Monthly'),
    KnobSpec.dropdown(
      id: 'density',
      label: 'density',
      initial: DsKeyValueRowDensity.regular,
      options: [
        for (final d in DsKeyValueRowDensity.values)
          KnobOption(d, d.name, code: 'DsKeyValueRowDensity.${d.name}'),
      ],
    ),
    KnobSpec.toggle(id: 'showInfoIcon', label: 'showInfoIcon', initial: false),
    KnobSpec.toggle(id: 'showChevron', label: 'showChevron', initial: false),
    KnobSpec.toggle(id: 'showDivider', label: 'showDivider', initial: true),
  ],
  build: (values) => _wrap(DsKeyValueRow(
    label: values.get<String>('label'),
    value: values.get<String>('value'),
    density: values.get<DsKeyValueRowDensity>('density'),
    showInfoIcon: values.get<bool>('showInfoIcon'),
    showChevron: values.get<bool>('showChevron'),
    showDivider: values.get<bool>('showDivider'),
  )),
  codeFor: (values) {
    final d = values.get<DsKeyValueRowDensity>('density');
    return 'DsKeyValueRow(\n'
        '${arg('label', str(values.get<String>('label')))}'
        '${arg('value', str(values.get<String>('value')))}'
        '${arg('density', 'DsKeyValueRowDensity.${d.name}')}'
        '${arg('showInfoIcon', values.get<bool>('showInfoIcon').toString())}'
        '${arg('showChevron', values.get<bool>('showChevron').toString())}'
        '${arg('showDivider', values.get<bool>('showDivider').toString())}'
        ')';
  },
);

Widget _wrap(Widget child) => ColoredBox(
      color: KeenaiColorsSurface.white,
      child: Padding(
        padding: const EdgeInsets.all(KeenaiSpacing.space20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 353),
          child: child,
        ),
      ),
    );
