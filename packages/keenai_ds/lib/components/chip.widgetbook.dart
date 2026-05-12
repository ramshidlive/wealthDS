import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../ds/chip.dart';
import '../tokens/tokens.dart';

@UseCase(
  name: 'Playground',
  type: DsChip,
  path: '[Components]/DsChip',
)
Widget dsChipPlayground(BuildContext context) {
  final label = context.knobs.string(
    label: 'label',
    initialValue: 'Stocks',
  );
  final variant = context.knobs.object.dropdown<DsChipVariant>(
    label: 'variant',
    options: DsChipVariant.values.toList(),
    initialOption: DsChipVariant.outlined,
    labelBuilder: (v) => v.name,
  );
  final showLeadingIcon = context.knobs.boolean(
    label: 'showLeadingIcon',
    initialValue: true,
  );

  return ColoredBox(
    color: KeenaiColorsBorder.medium,
    child: Center(
      child: DsChip(
        label: label,
        variant: variant,
        showLeadingIcon: showLeadingIcon,
      ),
    ),
  );
}
