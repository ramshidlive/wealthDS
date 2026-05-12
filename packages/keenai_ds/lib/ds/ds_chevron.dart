import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Stroke chevron for list rows / accordions (no icon font).
enum DsChevronDirection {
  right,
  up,
  down,
}

/// Vector chevron scaled to [size] (Figma 16px / 20px slots).
class DsChevron extends StatelessWidget {
  const DsChevron({
    super.key,
    required this.direction,
    required this.color,
    this.size = 20,
  });

  final DsChevronDirection direction;
  final Color color;
  final double size;

  double get _turnRadians => switch (direction) {
        DsChevronDirection.right => 0.0,
        DsChevronDirection.down => math.pi / 2,
        DsChevronDirection.up => -math.pi / 2,
      };

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _turnRadians,
      child: CustomPaint(
        size: Size.square(size),
        painter: _DsChevronStrokePainter(color: color),
      ),
    );
  }
}

/// Right-pointing chevron authored in a 20×20 box, scaled to layout [size].
final class _DsChevronStrokePainter extends CustomPainter {
  _DsChevronStrokePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide / 20.0;
    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2)
      ..scale(s)
      ..translate(-10, -10);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(7.5, 5)
      ..lineTo(12.5, 10)
      ..lineTo(7.5, 15);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _DsChevronStrokePainter oldDelegate) =>
      oldDelegate.color != color;
}
