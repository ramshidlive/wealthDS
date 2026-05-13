import 'package:flutter/widgets.dart';
import 'package:keenai_ds/components/asset_list_item.dart';
import 'package:keenai_ds/components/status_pill.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../knobs/knob.dart';
import '_code_utils.dart';
import 'showcase.dart';

final assetListItemShowcase = ComponentShowcase(
  id: 'asset_list_item',
  name: 'AssetListItem',
  description: 'Row for asset / holding lists with title, optional asset tag, '
      'order/status meta, and trailing value block.',
  knobs: [
    KnobSpec.text(id: 'title', label: 'title', initial: 'Apple'),
    KnobSpec.toggle(id: 'showAssetTag', label: 'showAssetTag', initial: true),
    KnobSpec.text(
      id: 'assetTagLabel',
      label: 'assetTagLabel',
      initial: 'Stock',
      enabledWhen: 'showAssetTag',
    ),
    KnobSpec.toggle(id: 'showChevron', label: 'showChevron', initial: true),
    KnobSpec.toggle(id: 'showOrderType', label: 'showOrderType', initial: false),
    KnobSpec.text(
      id: 'orderTypeLabel',
      label: 'orderTypeLabel',
      initial: 'S',
      enabledWhen: 'showOrderType',
    ),
    KnobSpec.dropdown(
      id: 'orderTypeTone',
      label: 'orderTypeTone',
      initial: DsStatusPillTone.danger,
      options: const [
        KnobOption(DsStatusPillTone.danger, 'danger',
            code: 'DsStatusPillTone.danger'),
        KnobOption(DsStatusPillTone.success, 'success',
            code: 'DsStatusPillTone.success'),
      ],
    ),
    KnobSpec.toggle(
        id: 'showOrderStatus', label: 'showOrderStatus', initial: false),
    KnobSpec.text(
      id: 'orderStatus',
      label: 'orderStatus',
      initial: 'FAILED',
      enabledWhen: 'showOrderStatus',
    ),
    KnobSpec.toggle(id: 'showValue', label: 'showValue', initial: true),
    KnobSpec.toggle(
      id: 'useValueText',
      label: 'valueText (nullable)',
      description: 'When off, valueText is null',
      initial: true,
    ),
    KnobSpec.text(
      id: 'valueText',
      label: 'valueText',
      initial: 'Qty 600',
      enabledWhen: 'useValueText',
    ),
    KnobSpec.dropdown(
      id: 'trailing',
      label: 'trailing',
      initial: DsAssetListItemTrailing.sub,
      options: [
        for (final v in DsAssetListItemTrailing.values)
          KnobOption(v, v.name, code: 'DsAssetListItemTrailing.${v.name}'),
      ],
    ),
    KnobSpec.text(
        id: 'trailingPrimaryValue',
        label: 'trailingPrimaryValue',
        initial: '145.20'),
  ],
  build: (values) => _wrap(DsAssetListItem(
    title: values.get<String>('title'),
    assetTagLabel: values.get<String>('assetTagLabel'),
    showAssetTag: values.get<bool>('showAssetTag'),
    showChevron: values.get<bool>('showChevron'),
    showOrderType: values.get<bool>('showOrderType'),
    showOrderStatus: values.get<bool>('showOrderStatus'),
    orderTypeLabel: values.get<String>('orderTypeLabel'),
    orderTypeTone: values.get<DsStatusPillTone>('orderTypeTone'),
    orderStatus: values.get<String>('orderStatus'),
    showValue: values.get<bool>('showValue'),
    valueText: values.get<bool>('useValueText')
        ? values.get<String>('valueText')
        : null,
    trailing: values.get<DsAssetListItemTrailing>('trailing'),
    trailingPrimaryValue: values.get<String>('trailingPrimaryValue'),
  )),
  codeFor: (values) {
    final tone = values.get<DsStatusPillTone>('orderTypeTone');
    final trailing = values.get<DsAssetListItemTrailing>('trailing');
    final useValueText = values.get<bool>('useValueText');
    return 'DsAssetListItem(\n'
        '${arg('title', str(values.get<String>('title')))}'
        '${arg('assetTagLabel', str(values.get<String>('assetTagLabel')))}'
        '${arg('showAssetTag', values.get<bool>('showAssetTag').toString())}'
        '${arg('showChevron', values.get<bool>('showChevron').toString())}'
        '${arg('showOrderType', values.get<bool>('showOrderType').toString())}'
        '${arg('showOrderStatus', values.get<bool>('showOrderStatus').toString())}'
        '${arg('orderTypeLabel', str(values.get<String>('orderTypeLabel')))}'
        '${arg('orderTypeTone', 'DsStatusPillTone.${tone.name}')}'
        '${arg('orderStatus', str(values.get<String>('orderStatus')))}'
        '${arg('showValue', values.get<bool>('showValue').toString())}'
        '${nullableStr('valueText', useValueText ? values.get<String>('valueText') : null, include: true)}'
        '${arg('trailing', 'DsAssetListItemTrailing.${trailing.name}')}'
        '${arg('trailingPrimaryValue', str(values.get<String>('trailingPrimaryValue')))}'
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
