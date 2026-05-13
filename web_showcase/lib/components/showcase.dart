import 'package:flutter/widgets.dart';

import '../knobs/knob.dart';

/// Two top-level groupings on the landing page / sidebar.
enum ShowcaseKind { atom, component }

/// Static descriptor for one design-system entry's showcase page.
class ComponentShowcase {
  const ComponentShowcase({
    required this.id,
    required this.name,
    required this.description,
    required this.knobs,
    required this.build,
    required this.codeFor,
    this.kind = ShowcaseKind.component,
  });

  final ShowcaseKind kind;

  /// URL-safe slug, used as the route key.
  final String id;

  /// Display name (e.g. `Chip`).
  final String name;

  /// One-line description rendered on the landing-page card.
  final String description;

  /// Ordered knob definitions; initial values seed [KnobValues].
  final List<KnobSpec> knobs;

  /// Builds the live preview from current knob values.
  final Widget Function(KnobValues values) build;

  /// Generates the copyable Dart snippet from current knob values.
  final String Function(KnobValues values) codeFor;
}
