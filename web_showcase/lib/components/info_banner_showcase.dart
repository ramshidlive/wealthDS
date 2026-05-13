import 'package:flutter/widgets.dart';
import 'package:keenai_ds/components/info_banner.dart';

import '../knobs/knob.dart';
import '_code_utils.dart';
import 'showcase.dart';

const _defaultMessage =
    'AAPL closed below the strike at maturity, so principal is being delivered in shares.';

final infoBannerShowcase = ComponentShowcase(
  id: 'info_banner',
  name: 'InfoBanner',
  description: 'Inline notice with leading info glyph in info/warning/'
      'success/danger tones.',
  knobs: [
    KnobSpec.text(id: 'message', label: 'message', initial: _defaultMessage),
    KnobSpec.dropdown(
      id: 'tone',
      label: 'tone',
      initial: DsInfoBannerTone.info,
      options: [
        for (final t in DsInfoBannerTone.values)
          KnobOption(t, t.name, code: 'DsInfoBannerTone.${t.name}'),
      ],
    ),
  ],
  build: (values) => _wrap(DsInfoBanner(
    message: values.get<String>('message'),
    tone: values.get<DsInfoBannerTone>('tone'),
  )),
  codeFor: (values) {
    final tone = values.get<DsInfoBannerTone>('tone');
    return 'DsInfoBanner(\n'
        '${arg('message', str(values.get<String>('message')))}'
        '${arg('tone', 'DsInfoBannerTone.${tone.name}')}'
        ')';
  },
);

Widget _wrap(Widget child) => ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 353),
      child: child,
    );
