import 'package:flutter/material.dart';
import './painter/painter.dart';
import 'dart:math' show Random;

class LineChart extends StatefulWidget {
  const LineChart({super.key});

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _lineController;
  late Animation<Offset> _lineAnimation;

  late double _dx = 0.0, _dy = 0.0;

  late List<TweenSequenceItem> data;

  @override
  void initState() {
    final List<Offset> randomOffsets = List.generate(
      10,
      (index) => Offset(Random().nextDouble(), Random().nextDouble()),
    );

    List<TweenSequenceItem<Offset>> tweenSequenceItems =
        randomOffsets.map((tuple) {
      return TweenSequenceItem<Offset>(
        tween: Tween<Offset>(begin: tuple, end: tuple + const Offset(0.0, 0.5)),
        weight: 1.0,
      );
    }).toList();

    _lineController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    _lineAnimation =
        TweenSequence<Offset>(tweenSequenceItems).animate(_lineController)
          ..addListener(() {
            setState(() {
              _dx = _lineAnimation.value.dx;
              _dy = _lineAnimation.value.dy;
            });
          });
    data = tweenSequenceItems;
  }

  @override
  void dispose() {
    _lineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LineChart'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: AnimatedBuilder(
                animation: _lineAnimation,
                builder: (context, child) => Transform(
                  transform: Matrix4.identity(),
                  child: CustomPaint(
                    painter: LineChartPainter(
                      dx: _dx,
                      dy: _dy,
                      data: data,
                    ),
                    child: Container(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
