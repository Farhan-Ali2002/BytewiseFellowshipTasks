import 'package:flutter/material.dart';
import 'dart:math' show Random;

final rng = Random();
const dayCount = 50;

class LineChartPainter extends CustomPainter {
  final double dx;
  final double dy;
  final List<TweenSequenceItem> data;

  @override
  LineChartPainter({required this.dx, required this.dy, required this.data});
  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dataPaint = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final axisPath = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height);
    canvas.drawPath(axisPath, axisPaint);

    final dataPath = Path()..moveTo(20, 20);
    for (var dataPoint in data) {
      dataPath.lineTo(dx, dy);
    }

    canvas.drawPath(dataPath, dataPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
