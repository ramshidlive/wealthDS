import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../components/showcase.dart';
import '../knobs/knob.dart';
import '../knobs/knobs_panel.dart';
import '../theme/showcase_theme.dart';

class ComponentPage extends StatefulWidget {
  const ComponentPage({super.key, required this.showcase});
  final ComponentShowcase showcase;

  @override
  State<ComponentPage> createState() => _ComponentPageState();
}

class _ComponentPageState extends State<ComponentPage> {
  late KnobValues _values = _initial();

  KnobValues _initial() => KnobValues({
        for (final k in widget.showcase.knobs) k.id: k.initial,
      });

  @override
  void didUpdateWidget(covariant ComponentPage old) {
    super.didUpdateWidget(old);
    if (old.showcase.id != widget.showcase.id) {
      _values = _initial();
    }
  }

  void _onKnobChanged(String id, Object value) {
    setState(() => _values = _values.copyWith(id, value));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MainArea(
            showcase: widget.showcase,
            values: _values,
          ),
        ),
        KnobsPanel(
          specs: widget.showcase.knobs,
          values: _values,
          onChanged: _onKnobChanged,
        ),
      ],
    );
  }
}

class _MainArea extends StatelessWidget {
  const _MainArea({required this.showcase, required this.values});
  final ComponentShowcase showcase;
  final KnobValues values;

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    return Container(
      color: c.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(KeenaiSpacing.space32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              showcase.name,
              style: KeenaiTypographyDisplay.display22Semibold
                  .copyWith(color: c.text),
            ),
            const SizedBox(height: KeenaiSpacing.space8),
            Text(
              showcase.description,
              style: KeenaiTypographyBody.body14Regular
                  .copyWith(color: c.muted),
            ),
            const SizedBox(height: KeenaiSpacing.space32),
            _SectionLabel(label: 'Live preview'),
            const SizedBox(height: KeenaiSpacing.space12),
            _PreviewSurface(child: showcase.build(values)),
            const SizedBox(height: KeenaiSpacing.space24),
            _SectionLabel(label: 'Code'),
            const SizedBox(height: KeenaiSpacing.space12),
            _CodeBlock(code: showcase.codeFor(values)),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    return Text(
      label.toUpperCase(),
      style: KeenaiTypographyBody.body10Semibold
          .copyWith(color: c.muted, letterSpacing: 1.4),
    );
  }
}

class _PreviewSurface extends StatelessWidget {
  const _PreviewSurface({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 220),
      padding: const EdgeInsets.all(KeenaiSpacing.space32),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(KeenaiRadius.radius12),
        border: Border.all(color: c.border),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class _CodeBlock extends StatefulWidget {
  const _CodeBlock({required this.code});
  final String code;
  @override
  State<_CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<_CodeBlock> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    if (!mounted) return;
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final codeBg = isDark ? const Color(0xFF0B1020) : const Color(0xFF111E2E);
    return Container(
      decoration: BoxDecoration(
        color: codeBg,
        borderRadius: BorderRadius.circular(KeenaiRadius.radius12),
        border: Border.all(color: c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: KeenaiSpacing.space16,
              vertical: KeenaiSpacing.space8,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'dart',
                  style: KeenaiTypographyBody.body10Semibold.copyWith(
                    color: Colors.white.withOpacity(0.55),
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: _copy,
                  icon: Icon(
                    _copied ? Icons.check : Icons.copy,
                    size: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  label: Text(
                    _copied ? 'Copied' : 'Copy',
                    style: KeenaiTypographyBody.body12Medium
                        .copyWith(color: Colors.white.withOpacity(0.9)),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: KeenaiSpacing.space8,
                      vertical: KeenaiSpacing.space4,
                    ),
                    minimumSize: Size.zero,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(KeenaiSpacing.space16),
            child: SelectableText(
              widget.code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                height: 1.55,
                color: Color(0xFFE8ECF1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
