/// Human-readable index of design tokens and where they appear in widgets.
///
/// Values mirror `tokens.json` / `KeenaiColors*`, [KeenaiSpacing], [KeenaiRadius],
/// and typography from [KeenaiTypographyBody] / [KeenaiTypographyDisplay].
/// Use with Widgetbook [InspectorAddon] for runtime inspection; this map is for
/// documentation and tooling only.
library;

/// One row in [TokenReference.tokens].
class TokenReferenceEntry {
  const TokenReferenceEntry({
    required this.tokenName,
    required this.category,
    required this.value,
    required this.usage,
    required this.components,
  });

  /// Leaf name or style id (e.g. `successText`, `space8`, `body14Medium`).
  final String tokenName;

  /// `color` | `spacing` | `radius` | `typography`.
  final String category;

  /// Serialized value (hex for colors, px/dp for spacing, etc.).
  final String value;

  final String usage;

  /// `Ds*` components that typically consume this token in `keenai_ds`.
  final List<String> components;
}

/// Static catalogue of tokens → usage → components.
abstract final class TokenReference {
  TokenReference._();

  /// Map key: dotted path for colors (`text.main`, `banner.successText`),
  /// `spacing.spaceN`, `radius.radiusN`, `typography.body.body14Medium`, etc.
  static const Map<String, TokenReferenceEntry> tokens = {
    // —— Colors: text ——
    'text.main': TokenReferenceEntry(
      tokenName: 'main',
      category: 'color',
      value: '#111E2E',
      usage: 'Primary body and titles on light surfaces',
      components: [
        'DsStatBox',
        'DsChip',
        'DsAssetListItem',
        'DsDetailListItem',
        'DsCollapsibleSection',
        'DsKeyValueRow',
        'DsStatusPill',
      ],
    ),
    'text.muted': TokenReferenceEntry(
      tokenName: 'muted',
      category: 'color',
      value: '#828A96',
      usage: 'Secondary / meta text',
      components: [
        'DsStatBox',
        'DsChip',
        'DsAssetListItem',
        'DsDetailListItem',
        'DsKeyValueRow',
        'DsStatusPill',
        'DsInfoBanner',
      ],
    ),
    'text.green': TokenReferenceEntry(
      tokenName: 'green',
      category: 'color',
      value: '#04B08D',
      usage: 'Positive / success foreground',
      components: ['DsStatusPill'],
    ),
    'text.red': TokenReferenceEntry(
      tokenName: 'red',
      category: 'color',
      value: '#E31937',
      usage: 'Error / danger foreground',
      components: ['DsStatusPill'],
    ),

    // —— Colors: border ——
    'border.strong': TokenReferenceEntry(
      tokenName: 'strong',
      category: 'color',
      value: '#CED1D9',
      usage: 'Strong strokes and dividers',
      components: ['DsInfoBanner', 'DsChip', 'DsKeyValueRow'],
    ),
    'border.medium': TokenReferenceEntry(
      tokenName: 'medium',
      category: 'color',
      value: '#E7E8EC',
      usage: 'Card and panel outlines',
      components: ['DsCollapsibleSection'],
    ),
    'border.light': TokenReferenceEntry(
      tokenName: 'light',
      category: 'color',
      value: '#EBEDF0',
      usage: 'Hairline row separators',
      components: ['DsAssetListItem', 'DsChip', 'DsDetailListItem', 'DsKeyValueRow'],
    ),

    // —— Colors: surface ——
    'surface.white': TokenReferenceEntry(
      tokenName: 'white',
      category: 'color',
      value: '#FFFFFF',
      usage: 'Default sheet / chip fill',
      components: ['DsChip', 'DsCollapsibleSection'],
    ),
    'surface.bg': TokenReferenceEntry(
      tokenName: 'bg',
      category: 'color',
      value: '#F5F6F7',
      usage: 'Page background',
      components: ['DsChip', 'DsStatusPill'],
    ),
    'surface.card': TokenReferenceEntry(
      tokenName: 'card',
      category: 'color',
      value: '#FAFBFC',
      usage: 'Subtle raised surfaces',
      components: ['DsInfoBanner', 'DsDetailListItem'],
    ),
    'surface.pink': TokenReferenceEntry(
      tokenName: 'pink',
      category: 'color',
      value: '#FEF6F7',
      usage: 'Danger-tone pill background',
      components: ['DsStatusPill'],
    ),
    'surface.teal': TokenReferenceEntry(
      tokenName: 'teal',
      category: 'color',
      value: '#EBF9F6',
      usage: 'Success-tone pill background',
      components: ['DsStatusPill'],
    ),

    // —— Colors: banner ——
    'banner.warningBg': TokenReferenceEntry(
      tokenName: 'warningBg',
      category: 'color',
      value: '#FFF8EC',
      usage: 'Warning banner fill',
      components: ['DsInfoBanner'],
    ),
    'banner.warningBorder': TokenReferenceEntry(
      tokenName: 'warningBorder',
      category: 'color',
      value: '#F2D49F',
      usage: 'Warning banner border',
      components: ['DsInfoBanner'],
    ),
    'banner.warningText': TokenReferenceEntry(
      tokenName: 'warningText',
      category: 'color',
      value: '#9A6506',
      usage: 'Warning banner text',
      components: ['DsInfoBanner'],
    ),
    'banner.successBg': TokenReferenceEntry(
      tokenName: 'successBg',
      category: 'color',
      value: '#EFFBF6',
      usage: 'Success banner fill',
      components: ['DsInfoBanner'],
    ),
    'banner.successBorder': TokenReferenceEntry(
      tokenName: 'successBorder',
      category: 'color',
      value: '#BCE8DA',
      usage: 'Success banner border',
      components: ['DsInfoBanner'],
    ),
    'banner.successText': TokenReferenceEntry(
      tokenName: 'successText',
      category: 'color',
      value: '#0F7E63',
      usage: 'Success state text / banner copy',
      components: ['DsInfoBanner', 'DsStatusPill'],
    ),
    'banner.dangerBg': TokenReferenceEntry(
      tokenName: 'dangerBg',
      category: 'color',
      value: '#FFF4F6',
      usage: 'Danger banner fill',
      components: ['DsInfoBanner'],
    ),
    'banner.dangerBorder': TokenReferenceEntry(
      tokenName: 'dangerBorder',
      category: 'color',
      value: '#F6C8D1',
      usage: 'Danger banner border',
      components: ['DsInfoBanner'],
    ),
    'banner.dangerText': TokenReferenceEntry(
      tokenName: 'dangerText',
      category: 'color',
      value: '#B8132D',
      usage: 'Danger state text / banner copy',
      components: ['DsInfoBanner', 'DsStatusPill'],
    ),

    // —— Spacing ——
    'spacing.space2': TokenReferenceEntry(
      tokenName: 'space2',
      category: 'spacing',
      value: '2',
      usage: 'Tight vertical rhythm',
      components: ['DsStatBox'],
    ),
    'spacing.space4': TokenReferenceEntry(
      tokenName: 'space4',
      category: 'spacing',
      value: '4',
      usage: 'Inline gaps and tight stacks',
      components: ['DsStatBox', 'DsChip', 'DsAssetListItem', 'DsDetailListItem', 'DsInfoBanner'],
    ),
    'spacing.space6': TokenReferenceEntry(
      tokenName: 'space6',
      category: 'spacing',
      value: '6',
      usage: 'Chip vertical padding',
      components: ['DsChip', 'DsStatusPill'],
    ),
    'spacing.space8': TokenReferenceEntry(
      tokenName: 'space8',
      category: 'spacing',
      value: '8',
      usage: 'Standard inline padding',
      components: [
        'DsChip',
        'DsAssetListItem',
        'DsDetailListItem',
        'DsInfoBanner',
        'DsKeyValueRow',
      ],
    ),
    'spacing.space12': TokenReferenceEntry(
      tokenName: 'space12',
      category: 'spacing',
      value: '12',
      usage: 'Comfortable padding and gaps',
      components: ['DsInfoBanner', 'DsDetailListItem', 'DsKeyValueRow'],
    ),
    'spacing.space16': TokenReferenceEntry(
      tokenName: 'space16',
      category: 'spacing',
      value: '16',
      usage: 'Screen gutters and chip horizontal padding',
      components: ['DsChip', 'DsAssetListItem', 'DsStatusPill', 'DsInfoBanner', 'DsCollapsibleSection'],
    ),
    'spacing.space20': TokenReferenceEntry(
      tokenName: 'space20',
      category: 'spacing',
      value: '20',
      usage: 'Section padding and column gaps',
      components: ['DsDetailListItem', 'DsCollapsibleSection'],
    ),
    'spacing.space24': TokenReferenceEntry(
      tokenName: 'space24',
      category: 'spacing',
      value: '24',
      usage: 'Key/value row horizontal rhythm (regular density)',
      components: ['DsKeyValueRow'],
    ),
    'spacing.space32': TokenReferenceEntry(
      tokenName: 'space32',
      category: 'spacing',
      value: '32',
      usage: 'Wide gutter between list leading and trailing',
      components: ['DsAssetListItem'],
    ),
    'spacing.space40': TokenReferenceEntry(
      tokenName: 'space40',
      category: 'spacing',
      value: '40',
      usage: 'Reserved scale slot',
      components: [],
    ),
    'spacing.space48': TokenReferenceEntry(
      tokenName: 'space48',
      category: 'spacing',
      value: '48',
      usage: 'Reserved scale slot',
      components: [],
    ),
    'spacing.space64': TokenReferenceEntry(
      tokenName: 'space64',
      category: 'spacing',
      value: '64',
      usage: 'Reserved scale slot',
      components: [],
    ),

    // —— Radius ——
    'radius.radius4': TokenReferenceEntry(
      tokenName: 'radius4',
      category: 'radius',
      value: '4',
      usage: 'Small controls',
      components: [],
    ),
    'radius.radius8': TokenReferenceEntry(
      tokenName: 'radius8',
      category: 'radius',
      value: '8',
      usage: 'Detail list leading thumbnail',
      components: ['DsDetailListItem'],
    ),
    'radius.radius10': TokenReferenceEntry(
      tokenName: 'radius10',
      category: 'radius',
      value: '10',
      usage: 'Reserved scale slot',
      components: [],
    ),
    'radius.radius12': TokenReferenceEntry(
      tokenName: 'radius12',
      category: 'radius',
      value: '12',
      usage: 'Cards, banners, collapsible sections',
      components: ['DsInfoBanner', 'DsCollapsibleSection'],
    ),
    'radius.radius16': TokenReferenceEntry(
      tokenName: 'radius16',
      category: 'radius',
      value: '16',
      usage: 'Large rounded surfaces',
      components: [],
    ),
    'radius.radius20': TokenReferenceEntry(
      tokenName: 'radius20',
      category: 'radius',
      value: '20',
      usage: 'Reserved scale slot',
      components: [],
    ),
    'radius.radius24': TokenReferenceEntry(
      tokenName: 'radius24',
      category: 'radius',
      value: '24',
      usage: 'Reserved scale slot',
      components: [],
    ),
    'radius.radius1000': TokenReferenceEntry(
      tokenName: 'radius1000',
      category: 'radius',
      value: '1000',
      usage: 'Fully pill-shaped chips and status pills',
      components: ['DsChip', 'DsStatusPill'],
    ),

    // —— Typography (body) ——
    'typography.body.body10Regular': TokenReferenceEntry(
      tokenName: 'body10Regular',
      category: 'typography',
      value: 'Geist 10/400, lh 14',
      usage: 'Dense supporting text',
      components: [],
    ),
    'typography.body.body10Semibold': TokenReferenceEntry(
      tokenName: 'body10Semibold',
      category: 'typography',
      value: 'Geist 10/600, lh 14',
      usage: 'Meta numerals (currency suffix, metrics)',
      components: ['DsAssetListItem', 'DsDetailListItem'],
    ),
    'typography.body.body12Regular': TokenReferenceEntry(
      tokenName: 'body12Regular',
      category: 'typography',
      value: 'Geist 12/400, lh 16',
      usage: 'Supporting lines and muted rows',
      components: ['DsStatBox', 'DsAssetListItem', 'DsDetailListItem', 'DsCollapsibleSection'],
    ),
    'typography.body.body12Medium': TokenReferenceEntry(
      tokenName: 'body12Medium',
      category: 'typography',
      value: 'Geist 12/500, lh 16',
      usage: 'Meta emphasis (pills, list meta)',
      components: ['DsChip', 'DsAssetListItem', 'DsStatusPill'],
    ),
    'typography.body.body14Regular': TokenReferenceEntry(
      tokenName: 'body14Regular',
      category: 'typography',
      value: 'Geist 14/400, lh 20',
      usage: 'Key labels and banner body',
      components: ['DsKeyValueRow', 'DsInfoBanner'],
    ),
    'typography.body.body14Medium': TokenReferenceEntry(
      tokenName: 'body14Medium',
      category: 'typography',
      value: 'Geist 14/500, lh 20',
      usage: 'Row titles and key-value values',
      components: ['DsAssetListItem', 'DsDetailListItem'],
    ),
    'typography.body.body14Semibold': TokenReferenceEntry(
      tokenName: 'body14Semibold',
      category: 'typography',
      value: 'Geist 14/600, lh 20',
      usage: 'List primary figures',
      components: ['DsAssetListItem', 'DsDetailListItem'],
    ),
    'typography.body.body16Medium': TokenReferenceEntry(
      tokenName: 'body16Medium',
      category: 'typography',
      value: 'Geist 16/500, lh 22',
      usage: 'Reserved for medium emphasis at 16px',
      components: [],
    ),
    'typography.body.body16Semibold': TokenReferenceEntry(
      tokenName: 'body16Semibold',
      category: 'typography',
      value: 'Geist 16/600, lh 22',
      usage: 'Section headers and large trailing values',
      components: ['DsStatBox', 'DsDetailListItem', 'DsCollapsibleSection'],
    ),

    // —— Typography (display) ——
    'typography.display.display22Semibold': TokenReferenceEntry(
      tokenName: 'display22Semibold',
      category: 'typography',
      value: 'Geist 22/600, lh 28',
      usage: 'Display headings',
      components: ['DsStatBox'],
    ),
    'typography.display.display26Medium': TokenReferenceEntry(
      tokenName: 'display26Medium',
      category: 'typography',
      value: 'Geist 26/500, lh 32',
      usage: 'Hero numerals',
      components: ['DsStatBox'],
    ),
  };
}
