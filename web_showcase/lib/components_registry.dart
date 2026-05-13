import 'atoms/tile_leading_showcase.dart';
import 'components/asset_list_item_showcase.dart';
import 'components/chip_showcase.dart';
import 'components/collapsible_section_showcase.dart';
import 'components/detail_list_item_showcase.dart';
import 'components/info_banner_showcase.dart';
import 'components/key_value_row_showcase.dart';
import 'components/showcase.dart';
import 'components/stat_box_showcase.dart';
import 'components/status_pill_showcase.dart';

final List<ComponentShowcase> atomsRegistry = [
  tileLeadingShowcase,
];

final List<ComponentShowcase> componentsRegistry = [
  assetListItemShowcase,
  chipShowcase,
  collapsibleSectionShowcase,
  detailListItemShowcase,
  infoBannerShowcase,
  keyValueRowShowcase,
  statBoxShowcase,
  statusPillShowcase,
];

/// Flat list used for lookup by id (e.g. when restoring the route).
List<ComponentShowcase> get allShowcases => [
      ...atomsRegistry,
      ...componentsRegistry,
    ];
