import 'package:flutter/material.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../theme/showcase_theme.dart';
import 'knob.dart';

class KnobLabel extends StatelessWidget {
  const KnobLabel({super.key, required this.spec});
  final KnobSpec spec;

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          spec.label,
          style: KeenaiTypographyBody.body12Medium.copyWith(color: c.text),
        ),
        if (spec.description != null) ...[
          const SizedBox(height: KeenaiSpacing.space2),
          Text(
            spec.description!,
            style: KeenaiTypographyBody.body10Regular.copyWith(color: c.muted),
          ),
        ],
      ],
    );
  }
}
