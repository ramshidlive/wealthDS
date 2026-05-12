import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';
import 'ds_chevron.dart';

/// Expandable card with title row and optional body — Figma `15:14` (CollapsibleSection).
///
/// Widgets layer only (no Material / Cupertino). Tap the header to expand/collapse.
class DsCollapsibleSection extends StatefulWidget {
  const DsCollapsibleSection({
    super.key,
    required this.title,
    this.child,
    this.initiallyExpanded = true,
  });

  final String title;
  final Widget? child;
  final bool initiallyExpanded;

  @override
  State<DsCollapsibleSection> createState() => _DsCollapsibleSectionState();
}

class _DsCollapsibleSectionState extends State<DsCollapsibleSection> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: KeenaiColorsSurface.white,
        borderRadius: BorderRadius.circular(KeenaiRadius.radius12),
        border: Border.all(color: KeenaiColorsBorder.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(KeenaiSpacing.space20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _expanded = !_expanded),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: KeenaiTypographyBody.body16Semibold
                          .copyWith(color: KeenaiColorsText.main),
                    ),
                  ),
                  DsChevron(
                    direction:
                        _expanded ? DsChevronDirection.up : DsChevronDirection.down,
                    color: KeenaiColorsText.muted,
                    size: KeenaiSpacing.space16,
                  ),
                ],
              ),
            ),
            if (_expanded && widget.child != null) ...[
              const SizedBox(height: KeenaiSpacing.space16),
              widget.child!,
            ],
          ],
        ),
      ),
    );
  }
}
