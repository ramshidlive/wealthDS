import 'package:flutter/widgets.dart';

/// Discriminator for knob UI rendering.
enum KnobType { text, dropdown, toggle, slider, color }

/// A single tunable parameter on a component showcase.
class KnobSpec {
  KnobSpec.text({
    required this.id,
    required this.label,
    required String initial,
    this.description,
    this.enabledWhen,
  })  : type = KnobType.text,
        options = const [],
        min = 0,
        max = 0,
        step = 0,
        initial = initial;

  KnobSpec.dropdown({
    required this.id,
    required this.label,
    required this.options,
    required Object initial,
    this.description,
    this.enabledWhen,
  })  : type = KnobType.dropdown,
        min = 0,
        max = 0,
        step = 0,
        initial = initial;

  KnobSpec.toggle({
    required this.id,
    required this.label,
    required bool initial,
    this.description,
    this.enabledWhen,
  })  : type = KnobType.toggle,
        options = const [],
        min = 0,
        max = 0,
        step = 0,
        initial = initial;

  KnobSpec.slider({
    required this.id,
    required this.label,
    required double initial,
    required this.min,
    required this.max,
    this.step = 1,
    this.description,
    this.enabledWhen,
  })  : type = KnobType.slider,
        options = const [],
        initial = initial;

  KnobSpec.color({
    required this.id,
    required this.label,
    required Color initial,
    this.description,
    this.enabledWhen,
  })  : type = KnobType.color,
        options = const [],
        min = 0,
        max = 0,
        step = 0,
        initial = initial;

  final String id;
  final String label;
  final String? description;
  final KnobType type;
  final List<KnobOption> options;
  final double min;
  final double max;
  final double step;
  final Object initial;

  /// If non-null, the id of a toggle knob whose value gates editability.
  /// When the referenced toggle is `false`, this knob renders disabled.
  final String? enabledWhen;
}

class KnobOption {
  const KnobOption(this.value, this.label, {this.code});
  final Object value;
  final String label;

  /// Optional source-code form (e.g. `DsChipVariant.outlined`).
  /// If null, falls back to `label`.
  final String? code;
}

/// Live knob values keyed by [KnobSpec.id].
class KnobValues {
  KnobValues(Map<String, Object> initial) : _values = Map.of(initial);

  final Map<String, Object> _values;

  T get<T>(String id) => _values[id] as T;
  Object? raw(String id) => _values[id];

  Map<String, Object> snapshot() => Map.unmodifiable(_values);

  KnobValues copyWith(String id, Object value) {
    final next = Map<String, Object>.of(_values);
    next[id] = value;
    return KnobValues(next);
  }
}
