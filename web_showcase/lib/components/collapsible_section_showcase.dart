import 'package:flutter/widgets.dart';
import 'package:keenai_ds/components/collapsible_section.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../knobs/knob.dart';
import '_code_utils.dart';
import 'showcase.dart';

const _defaultBody =
    'Body slot — any markup (KeyValueRow list, forms, rich text).';

final collapsibleSectionShowcase = ComponentShowcase(
  id: 'collapsible_section',
  name: 'CollapsibleSection',
  description: 'Header row that toggles a hidden body slot. Accepts any '
      'widget as its child.',
  knobs: [
    KnobSpec.text(id: 'title', label: 'title', initial: 'Pre-Agreed Terms'),
    KnobSpec.toggle(
      id: 'initiallyExpanded',
      label: 'initiallyExpanded',
      initial: true,
    ),
    KnobSpec.text(id: 'body', label: 'body text', initial: _defaultBody),
  ],
  build: (values) => _wrap(DsCollapsibleSection(
    key: ValueKey(values.get<bool>('initiallyExpanded')),
    title: values.get<String>('title'),
    initiallyExpanded: values.get<bool>('initiallyExpanded'),
    child: _body(values.get<String>('body')),
  )),
  codeFor: (values) => 'DsCollapsibleSection(\n'
      '${arg('title', str(values.get<String>('title')))}'
      '${arg('initiallyExpanded', values.get<bool>('initiallyExpanded').toString())}'
      '  child: Text(${str(values.get<String>('body'))}),\n'
      ')',
);

Widget _body(String text) => Text(
      text,
      style: KeenaiTypographyBody.body12Regular
          .copyWith(color: KeenaiColorsText.muted),
    );

Widget _wrap(Widget child) => ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 353),
      child: child,
    );
