import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../tokens/tokens.dart';
import 'tile_leading.dart';

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

@UseCase(
  name: 'Playground',
  type: TileLeading,
  path: '[Atoms]/TileLeading',
)
Widget tileLeadingPlayground(BuildContext context) {
  final showIcon = context.knobs.boolean(
    label: 'showIcon',
    initialValue: true,
  );
  final size = context.knobs.object.dropdown<TileLeadingSize>(
    label: 'size',
    options: TileLeadingSize.values.toList(),
    initialOption: TileLeadingSize.md,
    labelBuilder: (v) => v.name,
  );
  final title = context.knobs.string(
    label: 'title',
    initialValue: 'Order placed',
  );
  final showTag = context.knobs.boolean(
    label: 'showTag',
    initialValue: false,
  );
  final tag = context.knobs.string(
    label: 'tag',
    initialValue: 'FCN',
  );
  final showSubtitle = context.knobs.boolean(
    label: 'showSubtitle',
    initialValue: true,
  );
  final subtitle = context.knobs.string(
    label: 'subtitle',
    initialValue: '3:30 PM, 25 Aug 2025',
  );
  final showCaption = context.knobs.boolean(
    label: 'showCaption',
    initialValue: true,
  );
  final caption = context.knobs.string(
    label: 'caption',
    initialValue: 'Order ID: ODI5930234502',
  );

  final variant =
      showIcon ? TileLeadingVariant.icon : TileLeadingVariant.noIcon;

  return ColoredBox(
    color: KeenaiColorsBorder.medium,
    child: Center(
      child: TileLeading(
        variant: variant,
        size: size,
        icon: showIcon ? const _IconPlaceholder() : null,
        title: title,
        tag: showTag ? tag : null,
        subtitle: showSubtitle ? subtitle : null,
        caption: showCaption ? caption : null,
      ),
    ),
  );
}
