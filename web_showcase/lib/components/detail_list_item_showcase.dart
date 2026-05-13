import 'package:flutter/widgets.dart';
import 'package:keenai_ds/components/detail_list_item.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../knobs/knob.dart';
import '_code_utils.dart';
import 'showcase.dart';

final detailListItemShowcase = ComponentShowcase(
  id: 'detail_list_item',
  name: 'DetailListItem',
  description: 'Rich list row with optional leading, supporting line, and '
      'metric/text trailing.',
  knobs: [
    KnobSpec.text(id: 'title', label: 'title', initial: 'Coupons received'),
    KnobSpec.toggle(id: 'showSupporting', label: 'showSupporting', initial: true),
    KnobSpec.text(
      id: 'supportingText',
      label: 'supportingText',
      initial: '6 of 6 · USD 4,030 each',
      enabledWhen: 'showSupporting',
    ),
    KnobSpec.toggle(id: 'showTitleInfo', label: 'showTitleInfo', initial: false),
    KnobSpec.toggle(
        id: 'showLeadingIcon', label: 'showLeadingIcon', initial: false),
    KnobSpec.toggle(id: 'showChevron', label: 'showChevron', initial: false),
    KnobSpec.dropdown(
      id: 'align',
      label: 'align',
      initial: DsDetailListItemAlign.center,
      options: [
        for (final v in DsDetailListItemAlign.values)
          KnobOption(v, v.name, code: 'DsDetailListItemAlign.${v.name}'),
      ],
    ),
    KnobSpec.dropdown(
      id: 'density',
      label: 'density',
      initial: DsDetailListItemDensity.regular,
      options: [
        for (final v in DsDetailListItemDensity.values)
          KnobOption(v, v.name, code: 'DsDetailListItemDensity.${v.name}'),
      ],
    ),
    KnobSpec.dropdown(
      id: 'trailing',
      label: 'trailing',
      initial: DsDetailListItemTrailing.metric,
      options: [
        for (final v in DsDetailListItemTrailing.values)
          KnobOption(v, v.name, code: 'DsDetailListItemTrailing.${v.name}'),
      ],
    ),
    KnobSpec.toggle(
        id: 'showMetricCurrency',
        label: 'showMetricCurrency',
        initial: true),
    KnobSpec.text(
      id: 'metricCurrency',
      label: 'metricCurrency',
      initial: 'USD',
      enabledWhen: 'showMetricCurrency',
    ),
    KnobSpec.text(id: 'metricValue', label: 'metricValue', initial: '24.2K'),
    KnobSpec.text(id: 'trailingText', label: 'trailingText', initial: '24.2K'),
  ],
  build: (values) => _wrap(DsDetailListItem(
    title: values.get<String>('title'),
    supportingText: values.get<String>('supportingText'),
    showSupporting: values.get<bool>('showSupporting'),
    showTitleInfo: values.get<bool>('showTitleInfo'),
    showLeadingIcon: values.get<bool>('showLeadingIcon'),
    showChevron: values.get<bool>('showChevron'),
    align: values.get<DsDetailListItemAlign>('align'),
    density: values.get<DsDetailListItemDensity>('density'),
    trailing: values.get<DsDetailListItemTrailing>('trailing'),
    metricCurrency: values.get<String>('metricCurrency'),
    metricValue: values.get<String>('metricValue'),
    showMetricCurrency: values.get<bool>('showMetricCurrency'),
    trailingText: values.get<String>('trailingText'),
  )),
  codeFor: (values) {
    final align = values.get<DsDetailListItemAlign>('align');
    final density = values.get<DsDetailListItemDensity>('density');
    final trailing = values.get<DsDetailListItemTrailing>('trailing');
    return 'DsDetailListItem(\n'
        '${arg('title', str(values.get<String>('title')))}'
        '${arg('supportingText', str(values.get<String>('supportingText')))}'
        '${arg('showSupporting', values.get<bool>('showSupporting').toString())}'
        '${arg('showTitleInfo', values.get<bool>('showTitleInfo').toString())}'
        '${arg('showLeadingIcon', values.get<bool>('showLeadingIcon').toString())}'
        '${arg('showChevron', values.get<bool>('showChevron').toString())}'
        '${arg('align', 'DsDetailListItemAlign.${align.name}')}'
        '${arg('density', 'DsDetailListItemDensity.${density.name}')}'
        '${arg('trailing', 'DsDetailListItemTrailing.${trailing.name}')}'
        '${arg('metricCurrency', str(values.get<String>('metricCurrency')))}'
        '${arg('metricValue', str(values.get<String>('metricValue')))}'
        '${arg('showMetricCurrency', values.get<bool>('showMetricCurrency').toString())}'
        '${arg('trailingText', str(values.get<String>('trailingText')))}'
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
