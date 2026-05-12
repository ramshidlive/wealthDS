import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../ds/stat_box.dart';
import '../tokens/tokens.dart';

@UseCase(
  name: 'Playground',
  type: DsStatBox,
  path: '[Components]/DsStatBox',
)
Widget dsStatBoxPlayground(BuildContext context) {
  final label = context.knobs.string(
    label: 'label',
    initialValue: 'Trade date',
  );
  final value = context.knobs.string(
    label: 'value',
    initialValue: "09 Apr '26",
  );
  final showSupporting = context.knobs.boolean(
    label: 'supporting line',
    description: 'When off, supportingText & supportingLeadingLabel are null',
    initialValue: true,
  );
  final supportingText = showSupporting
      ? context.knobs.string(
          label: 'supportingText',
          initialValue: 'Monthly',
        )
      : null;
  final supportingLeadingRaw = showSupporting
      ? context.knobs.string(
          label: 'supportingLeadingLabel',
          initialValue: 'Freq: ',
        )
      : null;
  final supportingLeadingLabel =
      (supportingLeadingRaw == null || supportingLeadingRaw.isEmpty)
          ? null
          : supportingLeadingRaw;

  final size = context.knobs.object.dropdown<DsStatBoxSize>(
    label: 'size',
    options: DsStatBoxSize.values.toList(),
    initialOption: DsStatBoxSize.small,
    labelBuilder: (v) => v.name,
  );
  final alignment = context.knobs.object.dropdown<DsStatBoxAlignment>(
    label: 'alignment',
    options: DsStatBoxAlignment.values.toList(),
    initialOption: DsStatBoxAlignment.start,
    labelBuilder: (v) => v.name,
  );

  return ColoredBox(
    color: KeenaiColorsBorder.medium,
    child: Center(
      child: DsStatBox(
        label: label,
        value: value,
        supportingText: supportingText,
        supportingLeadingLabel: supportingLeadingLabel,
        size: size,
        alignment: alignment,
      ),
    ),
  );
}
