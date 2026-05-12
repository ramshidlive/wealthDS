import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../ds/detail_list_item.dart';
import '../tokens/tokens.dart';

@UseCase(
  name: 'Playground',
  type: DsDetailListItem,
  path: '[Components]/DsDetailListItem',
)
Widget dsDetailListItemPlayground(BuildContext context) {
  final title = context.knobs.string(
    label: 'title',
    initialValue: 'Coupons received',
  );
  final supportingText = context.knobs.string(
    label: 'supportingText',
    initialValue: '6 of 6 · USD 4,030 each',
  );
  final showSupporting = context.knobs.boolean(
    label: 'showSupporting',
    initialValue: true,
  );
  final showTitleInfo = context.knobs.boolean(
    label: 'showTitleInfo',
    initialValue: false,
  );
  final showLeadingIcon = context.knobs.boolean(
    label: 'showLeadingIcon',
    initialValue: false,
  );
  final showChevron = context.knobs.boolean(
    label: 'showChevron',
    initialValue: false,
  );
  final align = context.knobs.object.dropdown<DsDetailListItemAlign>(
    label: 'align',
    options: DsDetailListItemAlign.values.toList(),
    initialOption: DsDetailListItemAlign.center,
    labelBuilder: (v) => v.name,
  );
  final density = context.knobs.object.dropdown<DsDetailListItemDensity>(
    label: 'density',
    options: DsDetailListItemDensity.values.toList(),
    initialOption: DsDetailListItemDensity.regular,
    labelBuilder: (v) => v.name,
  );
  final trailing = context.knobs.object.dropdown<DsDetailListItemTrailing>(
    label: 'trailing',
    options: DsDetailListItemTrailing.values.toList(),
    initialOption: DsDetailListItemTrailing.metric,
    labelBuilder: (v) => v.name,
  );
  final metricCurrency = context.knobs.string(
    label: 'metricCurrency',
    initialValue: 'USD',
  );
  final metricValue = context.knobs.string(
    label: 'metricValue',
    initialValue: '24.2K',
  );
  final showMetricCurrency = context.knobs.boolean(
    label: 'showMetricCurrency',
    initialValue: true,
  );
  final trailingText = context.knobs.string(
    label: 'trailingText',
    initialValue: '24.2K',
  );

  return ColoredBox(
    color: KeenaiColorsBorder.medium,
    child: Center(
      child: ColoredBox(
        color: KeenaiColorsSurface.white,
        child: Padding(
          padding: const EdgeInsets.all(KeenaiSpacing.space20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 353),
            child: DsDetailListItem(
              title: title,
              supportingText: supportingText,
              showSupporting: showSupporting,
              showTitleInfo: showTitleInfo,
              showLeadingIcon: showLeadingIcon,
              showChevron: showChevron,
              align: align,
              density: density,
              trailing: trailing,
              metricCurrency: metricCurrency,
              metricValue: metricValue,
              showMetricCurrency: showMetricCurrency,
              trailingText: trailingText,
            ),
          ),
        ),
      ),
    ),
  );
}
