import 'package:flutter/material.dart';
import 'dart:math' show Random;

class MockData {
  final double x;
  final double y;
  MockData(this.x, this.y);
}

final rng = Random();
const dayCount = 50;

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final mock = List<MockData>.generate(dayCount, (index) {
      final y = double.parse(index.toString());
      final d = double.parse((index * 2).toString());
      return MockData(y, d);
    });

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

    final dataPath = Path()..moveTo(size.width, 0);
    for (var dataPoint in mock) {
      dataPath.lineTo(dataPoint.x, dataPoint.y);
    }

    canvas.drawPath(dataPath, dataPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
