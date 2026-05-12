import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../ds/key_value_row.dart';
import '../tokens/tokens.dart';

@UseCase(
  name: 'Playground',
  type: DsKeyValueRow,
  path: '[Components]/DsKeyValueRow',
)
Widget dsKeyValueRowPlayground(BuildContext context) {
  final label = context.knobs.string(
    label: 'label',
    initialValue: 'Coupon Frequency',
  );
  final value = context.knobs.string(
    label: 'value',
    initialValue: 'Monthly',
  );
  final density = context.knobs.object.dropdown<DsKeyValueRowDensity>(
    label: 'density',
    options: DsKeyValueRowDensity.values.toList(),
    initialOption: DsKeyValueRowDensity.regular,
    labelBuilder: (v) => v.name,
  );
  final showInfoIcon = context.knobs.boolean(
    label: 'showInfoIcon',
    initialValue: false,
  );
  final showChevron = context.knobs.boolean(
    label: 'showChevron',
    initialValue: false,
  );
  final showDivider = context.knobs.boolean(
    label: 'showDivider',
    initialValue: true,
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
            child: DsKeyValueRow(
              label: label,
              value: value,
              density: density,
              showInfoIcon: showInfoIcon,
              showChevron: showChevron,
              showDivider: showDivider,
            ),
          ),
        ),
      ),
    ),
  );
}
