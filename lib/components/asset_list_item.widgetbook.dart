import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'asset_list_item.dart';

@UseCase(
  name: 'Playground',
  type: DsAssetListItem,
  path: '[Components]/DsAssetListItem',
)
Widget dsAssetListItemPlayground(BuildContext context) {
  final title = context.knobs.string(
    label: 'title',
    initialValue: 'Apple',
  );
  final assetTagLabel = context.knobs.string(
    label: 'assetTagLabel',
    initialValue: 'Stock',
  );
  final showAssetTag = context.knobs.boolean(
    label: 'showAssetTag',
    initialValue: true,
  );
  final showChevron = context.knobs.boolean(
    label: 'showChevron',
    initialValue: true,
  );
  final showOrderType = context.knobs.boolean(
    label: 'showOrderType',
    initialValue: false,
  );
  final showStatusPill = context.knobs.boolean(
    label: 'showStatusPill',
    initialValue: false,
  );
  final showValue = context.knobs.boolean(
    label: 'showValue',
    initialValue: true,
  );
  final useValueText = context.knobs.boolean(
    label: 'valueText (nullable)',
    description: 'When off, valueText is null',
    initialValue: true,
  );
  final valueText = useValueText
      ? context.knobs.string(
          label: 'valueText',
          initialValue: 'Qty 600',
        )
      : null;

  final trailing = context.knobs.object.dropdown<DsAssetListItemTrailing>(
    label: 'trailing',
    options: DsAssetListItemTrailing.values.toList(),
    initialOption: DsAssetListItemTrailing.sub,
    labelBuilder: (v) => v.name,
  );

  final trailingPrimaryValue = context.knobs.string(
    label: 'trailingPrimaryValue',
    initialValue: '145.20',
  );
  final trailingCurrency = context.knobs.string(
    label: 'trailingCurrency',
    initialValue: 'USD',
  );
  final trailingSecondaryValue = context.knobs.string(
    label: 'trailingSecondaryValue',
    initialValue: 'Qty 600',
  );
  final trailingSingleLine = context.knobs.string(
    label: 'trailingSingleLine',
    initialValue: '145.20 K',
  );

  final contentWidth = context.knobs.double.input(
    label: 'contentWidth',
    initialValue: 353,
  );
  final titleMaxLines = context.knobs.int.slider(
    label: 'titleMaxLines',
    initialValue: 1,
    min: 1,
    max: 5,
  );

  return ColoredBox(
    color: const Color(0xFFE5E5E5),
    child: Center(
      child: ColoredBox(
        color: const Color(0xFFFFFFFF),
        child: DsAssetListItem(
          title: title,
          assetTagLabel: assetTagLabel,
          showAssetTag: showAssetTag,
          showChevron: showChevron,
          showOrderType: showOrderType,
          showStatusPill: showStatusPill,
          showValue: showValue,
          valueText: valueText,
          trailing: trailing,
          trailingPrimaryValue: trailingPrimaryValue,
          trailingCurrency: trailingCurrency,
          trailingSecondaryValue: trailingSecondaryValue,
          trailingSingleLine: trailingSingleLine,
          contentWidth: contentWidth,
          titleMaxLines: titleMaxLines,
        ),
      ),
    ),
  );
}
