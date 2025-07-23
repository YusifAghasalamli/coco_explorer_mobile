import 'package:flutter/material.dart';

class SegmentationPainter extends CustomPainter {
  final double originalWidth;
  final double originalHeight;
  final List<List<double>> segmentations;
  final Color color;

  SegmentationPainter({
    required this.originalWidth,
    required this.originalHeight,
    required this.segmentations,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / originalWidth;
    final scaleY = size.height / originalHeight;

    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    for (final polygon in segmentations) {
      final path = Path();
      for (int i = 0; i < polygon.length; i += 2) {
        final x = polygon[i] * scaleX;
        final y = polygon[i + 1] * scaleY;
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
