import 'package:flutter/material.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../components/showcase.dart';
import '../knobs/knob.dart';
import '../theme/showcase_theme.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
    required this.atoms,
    required this.components,
    required this.onOpen,
  });

  final List<ComponentShowcase> atoms;
  final List<ComponentShowcase> components;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    final total = atoms.length + components.length;
    return Container(
      color: c.background,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final cols = w >= 1400
              ? 4
              : w >= 1080
                  ? 3
                  : w >= 720
                      ? 2
                      : 1;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(KeenaiSpacing.space40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Library',
                  style: KeenaiTypographyDisplay.display22Semibold
                      .copyWith(color: c.text),
                ),
                const SizedBox(height: KeenaiSpacing.space8),
                Text(
                  '$total entries from keenai_ds. Atoms are the primitive '
                  'building blocks; components compose them into list rows, '
                  'sections, and richer surfaces.',
                  style: KeenaiTypographyBody.body14Regular
                      .copyWith(color: c.muted),
                ),
                const SizedBox(height: KeenaiSpacing.space32),
                if (atoms.isNotEmpty) ...[
                  _GroupHeading(label: 'ATOMS'),
                  const SizedBox(height: KeenaiSpacing.space16),
                  _CardsGrid(
                    items: atoms,
                    cols: cols,
                    onOpen: onOpen,
                  ),
                  const SizedBox(height: KeenaiSpacing.space40),
                ],
                if (components.isNotEmpty) ...[
                  _GroupHeading(label: 'COMPONENTS'),
                  const SizedBox(height: KeenaiSpacing.space16),
                  _CardsGrid(
                    items: components,
                    cols: cols,
                    onOpen: onOpen,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GroupHeading extends StatelessWidget {
  const _GroupHeading({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    return Text(
      label,
      style: KeenaiTypographyBody.body10Semibold
          .copyWith(color: c.muted, letterSpacing: 1.2),
    );
  }
}

class _CardsGrid extends StatelessWidget {
  const _CardsGrid({
    required this.items,
    required this.cols,
    required this.onOpen,
  });
  final List<ComponentShowcase> items;
  final int cols;
  final ValueChanged<String> onOpen;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        mainAxisSpacing: KeenaiSpacing.space20,
        crossAxisSpacing: KeenaiSpacing.space20,
        childAspectRatio: 1.05,
      ),
      itemBuilder: (_, i) => _ComponentCard(
        showcase: items[i],
        onTap: () => onOpen(items[i].id),
      ),
    );
  }
}

class _ComponentCard extends StatefulWidget {
  const _ComponentCard({required this.showcase, required this.onTap});
  final ComponentShowcase showcase;
  final VoidCallback onTap;

  @override
  State<_ComponentCard> createState() => _ComponentCardState();
}

class _ComponentCardState extends State<_ComponentCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(KeenaiRadius.radius12),
            border: Border.all(
              color: _hover ? KeenaiColorsText.green : c.border,
              width: _hover ? 1.5 : 1,
            ),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: c.background,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(KeenaiRadius.radius12),
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(KeenaiSpacing.space20),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: _previewFor(widget.showcase),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(KeenaiSpacing.space16),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: c.border)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.showcase.name,
                      style: KeenaiTypographyBody.body14Semibold
                          .copyWith(color: c.text),
                    ),
                    const SizedBox(height: KeenaiSpacing.space4),
                    Text(
                      widget.showcase.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: KeenaiTypographyBody.body12Regular
                          .copyWith(color: c.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Initial-values thumbnail rendered through the showcase's own builder.
  Widget _previewFor(ComponentShowcase s) {
    final initial = <String, Object>{
      for (final k in s.knobs) k.id: k.initial,
    };
    return s.build(KnobValues(initial));
  }
}
