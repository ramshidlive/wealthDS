import 'package:flutter/material.dart';
import 'package:keenai_ds/tokens/tokens.dart';

import '../components/showcase.dart';
import '../theme/showcase_theme.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({
    super.key,
    required this.atoms,
    required this.components,
    required this.selectedId,
    required this.onSelected,
  });

  final List<ComponentShowcase> atoms;
  final List<ComponentShowcase> components;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String _query = '';

  List<ComponentShowcase> _filter(List<ComponentShowcase> src) {
    if (_query.isEmpty) return src;
    final q = _query.toLowerCase();
    return src
        .where((cs) =>
            cs.name.toLowerCase().contains(q) ||
            cs.description.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    final atoms = _filter(widget.atoms);
    final components = _filter(widget.components);

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(right: BorderSide(color: c.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              KeenaiSpacing.space20,
              KeenaiSpacing.space20,
              KeenaiSpacing.space20,
              KeenaiSpacing.space12,
            ),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              style: KeenaiTypographyBody.body14Regular.copyWith(color: c.text),
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search components',
                hintStyle: KeenaiTypographyBody.body14Regular
                    .copyWith(color: c.muted),
                prefixIcon: Icon(Icons.search, size: 18, color: c.muted),
                filled: true,
                fillColor: c.card,
                contentPadding: const EdgeInsets.symmetric(
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(KeenaiRadius.radius8),
                  borderSide:
                      BorderSide(color: KeenaiColorsText.green, width: 1.5),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: KeenaiSpacing.space4,
              ),
              children: [
                if (atoms.isNotEmpty) ...[
                  _SectionHeading(label: 'ATOMS'),
                  for (final s in atoms)
                    _SidebarItem(
                      showcase: s,
                      selected: s.id == widget.selectedId,
                      onTap: () => widget.onSelected(s.id),
                    ),
                  const SizedBox(height: KeenaiSpacing.space12),
                ],
                if (components.isNotEmpty) ...[
                  _SectionHeading(label: 'COMPONENTS'),
                  for (final s in components)
                    _SidebarItem(
                      showcase: s,
                      selected: s.id == widget.selectedId,
                      onTap: () => widget.onSelected(s.id),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KeenaiSpacing.space24,
        vertical: KeenaiSpacing.space4,
      ),
      child: Text(
        label,
        style: KeenaiTypographyBody.body10Semibold.copyWith(
          color: c.muted,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.showcase,
    required this.selected,
    required this.onTap,
  });
  final ComponentShowcase showcase;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ShowcaseColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KeenaiSpacing.space12,
        vertical: 2,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(KeenaiRadius.radius8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: KeenaiSpacing.space12,
            vertical: KeenaiSpacing.space8,
          ),
          decoration: BoxDecoration(
            color: selected ? c.card : Colors.transparent,
            borderRadius: BorderRadius.circular(KeenaiRadius.radius8),
          ),
          child: Text(
            showcase.name,
            style: (selected
                    ? KeenaiTypographyBody.body14Semibold
                    : KeenaiTypographyBody.body14Regular)
                .copyWith(
              color: selected ? KeenaiColorsText.green : c.text,
            ),
          ),
        ),
      ),
    );
  }
}
