import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vc;

class ThreeD extends StatefulWidget {
  const ThreeD({super.key});

  @override
  State<ThreeD> createState() => _ThreeDState();
}

class _ThreeDState extends State<ThreeD> with TickerProviderStateMixin {
  final widthHeight = 100.0;
  late AnimationController _xcontroller;
  late AnimationController _ycontroller;
  late AnimationController _zcontroller;
  late Tween<double> _animation;
  @override
  void initState() {
    _xcontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _ycontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _zcontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 40));

    _animation = Tween(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    _xcontroller.dispose();
    _ycontroller.dispose();
    _zcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xcontroller
      ..reset()
      ..repeat();
    _ycontroller
      ..reset()
      ..repeat();
    _zcontroller
      ..reset()
      ..repeat();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 200, width: double.infinity),
          AnimatedBuilder(
            animation:
                Listenable.merge([_xcontroller, _ycontroller, _zcontroller]),
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..rotateX(_animation.evaluate(_xcontroller))
                  ..rotateY(_animation.evaluate(_ycontroller))
                  ..rotateZ(_animation.evaluate(_zcontroller)),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      width: widthHeight,
                      height: widthHeight,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 11, 14, 172)),
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(vc.Vector3(0, 0, -(widthHeight))),
                      child: Container(
                        width: widthHeight,
                        height: widthHeight,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 231, 172, 44)),
                      ),
                    ),
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        width: widthHeight,
                        height: widthHeight,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 218, 255, 56)),
                      ),
                    ),
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()..rotateY(-(pi / 2)),
                      child: Container(
                        width: widthHeight,
                        height: widthHeight,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 241, 8, 27)),
                      ),
                    ),
                    Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()..rotateX(-(pi / 2)),
                      child: Container(
                        width: widthHeight,
                        height: widthHeight,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 56, 207, 218)),
                      ),
                    ),
                    Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()..rotateX((pi / 2)),
                      child: Container(
                          width: widthHeight,
                          height: widthHeight,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 29, 211, 89),
                          )),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
