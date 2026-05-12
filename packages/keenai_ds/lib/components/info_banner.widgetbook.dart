import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'info_banner.dart';

@UseCase(
  name: 'Playground',
  type: DsInfoBanner,
  path: '[Components]/DsInfoBanner',
)
Widget dsInfoBannerPlayground(BuildContext context) {
  final message = context.knobs.string(
    label: 'message',
    initialValue:
        'AAPL closed below the strike at maturity, so principal is being delivered in shares.',
  );
  final tone = context.knobs.object.dropdown<DsInfoBannerTone>(
    label: 'tone',
    options: DsInfoBannerTone.values.toList(),
    initialOption: DsInfoBannerTone.info,
    labelBuilder: (v) => v.name,
  );

  return ColoredBox(
    color: const Color(0xFFE5E5E5),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 353),
        child: DsInfoBanner(
          message: message,
          tone: tone,
        ),
      ),
    ),
  );
}
