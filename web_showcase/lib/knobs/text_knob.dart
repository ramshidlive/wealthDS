import 'package:flutter/material.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../theme/showcase_theme.dart';
import '_label.dart';
import 'knob.dart';

class TextKnob extends StatefulWidget {
  const TextKnob({
    super.key,
    required this.spec,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final KnobSpec spec;
  final String value;
  final ValueChanged<String> onChanged;
  final bool enabled;

  @override
  State<TextKnob> createState() => _TextKnobState();
}

class _TextKnobState extends State<TextKnob> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.value);

  @override
  void didUpdateWidget(covariant TextKnob old) {
    super.didUpdateWidget(old);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    final disabled = !widget.enabled;
    final fillColor = disabled ? c.card : c.surface;
    final textColor = disabled ? c.muted : c.text;
    return Opacity(
      opacity: disabled ? 0.55 : 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KnobLabel(spec: widget.spec),
          const SizedBox(height: KeenaiSpacing.space6),
          TextField(
            controller: _controller,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            style:
                KeenaiTypographyBody.body14Regular.copyWith(color: textColor),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: fillColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: KeenaiSpacing.space12,
                vertical: KeenaiSpacing.space8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(KeenaiRadius.radius8),
                borderSide: BorderSide(color: c.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(KeenaiRadius.radius8),
                borderSide: BorderSide(color: c.border),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(KeenaiRadius.radius8),
                borderSide: BorderSide(color: c.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(KeenaiRadius.radius8),
                borderSide:
                    BorderSide(color: KeenaiColorsText.green, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
