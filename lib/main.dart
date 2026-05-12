import 'package:flutter/widgets.dart';

import 'ds/asset_list_item.dart';
import 'ds/stat_box.dart';
import 'ds/status_pill.dart';

void main() {
  runApp(const DesignSystemPreviewApp());
}

/// Minimal shell without Material or Cupertino — only [WidgetsApp].
class DesignSystemPreviewApp extends StatelessWidget {
  const DesignSystemPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: const MediaQueryData(size: Size(800, 1200)),
        child: WidgetsApp(
          title: 'My Design System',
          color: const Color(0xFF111E2E),
          debugShowCheckedModeBanner: false,
          builder: (context, _) => const _PreviewCanvas(),
        ),
      ),
    );
  }
}

/// Dashed preview surface matching `.statbox-preview-wrap` (tokenized).
class _PreviewCanvas extends StatelessWidget {
  const _PreviewCanvas();

  static const Color _canvas = Color(0xFFE5E5E5);
  static const Color _dashBorder = Color(0xFFE7E8EC);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _canvas,
      child: Center(
        child: CustomPaint(
          painter: _DashedRoundedRectPainter(
            color: _dashBorder,
            borderRadius: 10,
            strokeWidth: 1,
            dashLength: 4,
            gapLength: 4,
          ),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: _StatusPillPreviewGrid(),
          ),
        ),
      ),
    );
  }
}

/// Matches Figma StatusPill matrix (MD row, SM row) — node `9:14`.
class _StatusPillPreviewGrid extends StatelessWidget {
  const _StatusPillPreviewGrid();

  static const String _label = 'KI Breached';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DsStatusPill(label: _label, tone: DsStatusPillTone.danger),
            SizedBox(width: 8),
            DsStatusPill(
              label: _label,
              tone: DsStatusPillTone.success,
            ),
            SizedBox(width: 8),
            DsStatusPill(
              label: _label,
              tone: DsStatusPillTone.neutral,
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DsStatusPill(
              label: _label,
              size: DsStatusPillSize.sm,
              tone: DsStatusPillTone.danger,
            ),
            SizedBox(width: 8),
            DsStatusPill(
              label: _label,
              size: DsStatusPillSize.sm,
              tone: DsStatusPillTone.success,
            ),
            SizedBox(width: 8),
            DsStatusPill(
              label: _label,
              size: DsStatusPillSize.sm,
              tone: DsStatusPillTone.neutral,
            ),
          ],
        ),
        const SizedBox(height: 24),
        const DsStatBox(
          label: 'Trade date',
          value: "09 Apr '26",
          supportingLeadingLabel: 'Freq: ',
          supportingText: 'Monthly',
          size: DsStatBoxSize.small,
          alignment: DsStatBoxAlignment.start,
        ),
        const SizedBox(height: 24),
        ColoredBox(
          color: const Color(0xFFFFFFFF),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              DsAssetListItem(
                title: 'Apple',
                trailing: DsAssetListItemTrailing.sub,
              ),
              DsAssetListItem(
                title: 'US Dollar',
                trailing: DsAssetListItemTrailing.single,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 1px dashed border — approximates CSS `border: 1px dashed var(--border-medium)`.
class _DashedRoundedRectPainter extends CustomPainter {
  _DashedRoundedRectPainter({
    required this.color,
    required this.borderRadius,
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
  });

  final Color color;
  final double borderRadius;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(borderRadius),
    );
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double len = dashLength.clamp(0, metric.length - distance);
        final Path extract = metric.extractPath(distance, distance + len);
        canvas.drawPath(extract, paint);
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRoundedRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.gapLength != gapLength;
  }
}
