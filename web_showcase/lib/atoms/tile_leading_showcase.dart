import 'package:flutter/widgets.dart';
import 'package:keenai_ds/components/status_pill.dart';
import 'package:keenai_ds/components/tile_leading.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../components/_code_utils.dart';
import '../components/showcase.dart';
import '../knobs/knob.dart';

/// Placeholder square used while icon-selection isn't exposed as a knob.
class _IconPlaceholder extends StatelessWidget {
  const _IconPlaceholder();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: KeenaiSpacing.space40,
      height: KeenaiSpacing.space40,
      decoration: BoxDecoration(
        color: KeenaiColorsBorder.medium,
        borderRadius: BorderRadius.circular(KeenaiRadius.radius8),
      ),
    );
  }
}

List<KnobOption> _toneOptions() => [
      for (final t in DsStatusPillTone.values)
        KnobOption(t, t.name, code: 'DsStatusPillTone.${t.name}'),
    ];

final tileLeadingShowcase = ComponentShowcase(
  id: 'tile_leading',
  name: 'TileLeading',
  kind: ShowcaseKind.atom,
  description:
      'Compact leading block for list rows. Toggle the leading icon on or off; '
      'pick md (14 semibold title) or lg (16 semibold title from tokens). '
      'Tag, subtitle, and caption use body12Regular. '
      'Supports title · tag, optional pills (DsStatusPill), subtitle, and '
      'caption.',
  knobs: [
    KnobSpec.toggle(
      id: 'showIcon',
      label: 'show icon',
      description: 'Leading placeholder slot on / off',
      initial: true,
    ),
    KnobSpec.dropdown(
      id: 'size',
      label: 'size',
      initial: TileLeadingSize.md,
      options: const [
        KnobOption(TileLeadingSize.md, 'md', code: 'TileLeadingSize.md'),
        KnobOption(TileLeadingSize.lg, 'lg', code: 'TileLeadingSize.lg'),
      ],
    ),
    KnobSpec.text(id: 'title', label: 'title', initial: 'Order placed'),
    KnobSpec.toggle(id: 'showTag', label: 'show tag', initial: false),
    KnobSpec.text(
      id: 'tag',
      label: 'tag',
      initial: 'FCN',
      enabledWhen: 'showTag',
    ),
    KnobSpec.toggle(id: 'showPill1', label: 'show pill 1', initial: false),
    KnobSpec.text(
      id: 'pill1Label',
      label: 'pill 1 label',
      initial: 'S',
      enabledWhen: 'showPill1',
    ),
    KnobSpec.dropdown(
      id: 'pill1Tone',
      label: 'pill 1 tone',
      initial: DsStatusPillTone.danger,
      options: _toneOptions(),
      enabledWhen: 'showPill1',
    ),
    KnobSpec.toggle(id: 'showPill2', label: 'show pill 2', initial: false),
    KnobSpec.text(
      id: 'pill2Label',
      label: 'pill 2 label',
      initial: 'FAILED',
      enabledWhen: 'showPill2',
    ),
    KnobSpec.dropdown(
      id: 'pill2Tone',
      label: 'pill 2 tone',
      initial: DsStatusPillTone.neutral,
      options: _toneOptions(),
      enabledWhen: 'showPill2',
    ),
    KnobSpec.toggle(
      id: 'showSubtitle',
      label: 'show subtitle',
      initial: true,
    ),
    KnobSpec.text(
      id: 'subtitle',
      label: 'subtitle',
      initial: '3:30 PM, 25 Aug 2025',
      enabledWhen: 'showSubtitle',
    ),
    KnobSpec.toggle(
      id: 'showCaption',
      label: 'show caption',
      description: 'Third line, e.g. Order ID',
      initial: true,
    ),
    KnobSpec.text(
      id: 'caption',
      label: 'caption',
      initial: 'Order ID: ODI5930234502',
      enabledWhen: 'showCaption',
    ),
  ],
  build: (values) {
    final showIcon = values.get<bool>('showIcon');
    final variant =
        showIcon ? TileLeadingVariant.icon : TileLeadingVariant.noIcon;
    final size = values.get<TileLeadingSize>('size');
    final pills = <TilePill>[
      if (values.get<bool>('showPill1'))
        TilePill(
          label: values.get<String>('pill1Label'),
          tone: values.get<DsStatusPillTone>('pill1Tone'),
        ),
      if (values.get<bool>('showPill2'))
        TilePill(
          label: values.get<String>('pill2Label'),
          tone: values.get<DsStatusPillTone>('pill2Tone'),
        ),
    ];
    return TileLeading(
      variant: variant,
      size: size,
      icon: showIcon ? const _IconPlaceholder() : null,
      title: values.get<String>('title'),
      tag: values.get<bool>('showTag') ? values.get<String>('tag') : null,
      pills: pills,
      subtitle: values.get<bool>('showSubtitle')
          ? values.get<String>('subtitle')
          : null,
      caption: values.get<bool>('showCaption')
          ? values.get<String>('caption')
          : null,
    );
  },
  codeFor: (values) {
    final showIcon = values.get<bool>('showIcon');
    final variant =
        showIcon ? TileLeadingVariant.icon : TileLeadingVariant.noIcon;
    final size = values.get<TileLeadingSize>('size');
    final showSub = values.get<bool>('showSubtitle');
    final showCap = values.get<bool>('showCaption');
    final showTag = values.get<bool>('showTag');
    final showP1 = values.get<bool>('showPill1');
    final showP2 = values.get<bool>('showPill2');
    final pillEntries = <String>[
      if (showP1)
        'TilePill(label: ${str(values.get<String>('pill1Label'))}, '
            'tone: DsStatusPillTone.${values.get<DsStatusPillTone>('pill1Tone').name})',
      if (showP2)
        'TilePill(label: ${str(values.get<String>('pill2Label'))}, '
            'tone: DsStatusPillTone.${values.get<DsStatusPillTone>('pill2Tone').name})',
    ];
    final pillsLiteral = pillEntries.isEmpty
        ? ''
        : '  pills: const [\n    ${pillEntries.join(',\n    ')},\n  ],\n';
    final iconLiteral = showIcon
        ? '  icon: const SizedBox(width: 40, height: 40),\n'
        : '';
    return 'TileLeading(\n'
        '${arg('variant', 'TileLeadingVariant.${variant.name}')}'
        '${arg('size', 'TileLeadingSize.${size.name}', include: size != TileLeadingSize.md)}'
        '$iconLiteral'
        '${arg('title', str(values.get<String>('title')))}'
        '${nullableStr('tag', showTag ? values.get<String>('tag') : null, include: true)}'
        '$pillsLiteral'
        '${nullableStr('subtitle', showSub ? values.get<String>('subtitle') : null, include: true)}'
        '${nullableStr('caption', showCap ? values.get<String>('caption') : null, include: true)}'
        ')';
  },
);
