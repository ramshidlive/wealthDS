import 'package:flutter/widgets.dart';
import 'package:keenai_ds/components/chip.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../knobs/knob.dart';
import '_code_utils.dart';
import 'showcase.dart';

final chipShowcase = ComponentShowcase(
  id: 'chip',
  name: 'Chip',
  description: 'Pill-shaped filter chip with selected, outlined, and '
      'multi-select variants.',
  knobs: [
    KnobSpec.text(id: 'label', label: 'label', initial: 'Stocks'),
    KnobSpec.dropdown(
      id: 'variant',
      label: 'variant',
      initial: DsChipVariant.outlined,
      options: [
        for (final v in DsChipVariant.values)
          KnobOption(v, v.name, code: 'DsChipVariant.${v.name}'),
      ],
    ),
    KnobSpec.toggle(
      id: 'showLeadingIcon',
      label: 'showLeadingIcon',
      initial: true,
    ),
  ],
  build: (values) => _wrap(DsChip(
    label: values.get<String>('label'),
    variant: values.get<DsChipVariant>('variant'),
    showLeadingIcon: values.get<bool>('showLeadingIcon'),
  )),
  codeFor: (values) {
    final variant = values.get<DsChipVariant>('variant');
    return 'DsChip(\n'
        '${arg('label', str(values.get<String>('label')))}'
        '${arg('variant', 'DsChipVariant.${variant.name}')}'
        '${arg('showLeadingIcon', values.get<bool>('showLeadingIcon').toString())}'
        ')';
  },
);

/// All chip variants paint on `border.medium` per the Widgetbook story, so
/// keep that as the preview backdrop for visual parity.
Widget _wrap(Widget child) => ColoredBox(
      color: KeenaiColorsBorder.medium,
      child: Padding(
        padding: const EdgeInsets.all(KeenaiSpacing.space20),
        child: child,
      ),
    );
