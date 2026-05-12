import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../ds/status_pill.dart';
import '../tokens/tokens.dart';

@UseCase(
  name: 'Playground',
  type: DsStatusPill,
  path: '[Components]/DsStatusPill',
)
Widget dsStatusPillPlayground(BuildContext context) {
  final label = context.knobs.string(
    label: 'label',
    initialValue: 'KI Breached',
  );
  final size = context.knobs.object.dropdown<DsStatusPillSize>(
    label: 'size',
    options: DsStatusPillSize.values.toList(),
    initialOption: DsStatusPillSize.md,
    labelBuilder: (v) => v.name,
  );
  final tone = context.knobs.object.dropdown<DsStatusPillTone>(
    label: 'tone',
    options: DsStatusPillTone.values.toList(),
    initialOption: DsStatusPillTone.danger,
    labelBuilder: (v) => v.name,
  );

  return ColoredBox(
    color: KeenaiColorsBorder.medium,
    child: Center(
      child: DsStatusPill(
        label: label,
        size: size,
        tone: tone,
      ),
    ),
  );
}
