import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../ds/collapsible_section.dart';
import '../tokens/tokens.dart';

@UseCase(
  name: 'Playground',
  type: DsCollapsibleSection,
  path: '[Components]/DsCollapsibleSection',
)
Widget dsCollapsibleSectionPlayground(BuildContext context) {
  final title = context.knobs.string(
    label: 'title',
    initialValue: 'Pre-Agreed Terms',
  );
  final initiallyExpanded = context.knobs.boolean(
    label: 'initiallyExpanded',
    initialValue: true,
  );
  final body = context.knobs.string(
    label: 'body text',
    initialValue:
        'Body slot — any markup (KeyValueRow list, forms, rich text).',
  );

  return ColoredBox(
    color: KeenaiColorsBorder.medium,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(KeenaiSpacing.space20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 353),
          child: DsCollapsibleSection(
            key: ValueKey<bool>(initiallyExpanded),
            title: title,
            initiallyExpanded: initiallyExpanded,
            child: Text(
              body,
              style: KeenaiTypographyBody.body12Regular
                  .copyWith(color: KeenaiColorsText.muted),
            ),
          ),
        ),
      ),
    ),
  );
}
