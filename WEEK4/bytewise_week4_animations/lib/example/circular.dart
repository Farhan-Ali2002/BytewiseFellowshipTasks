import 'package:flutter/material.dart';
import 'dart:math' show pi;

enum CircleSide { right, left }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    var path = Path();
    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;

        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;

        break;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );
    path.close();

    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  const HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class Circular extends StatefulWidget {
  const Circular({super.key});

  @override
  State<Circular> createState() => _CircularState();
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class _CircularState extends State<Circular> with TickerProviderStateMixin {
  late AnimationController _counterClockWiseController;
  late Animation _counterclockwiseanimation;
  late AnimationController _flipController;
  late Animation _flipAnimation;

  @override
  void initState() {
    super.initState();
    _counterClockWiseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _counterclockwiseanimation = Tween(begin: 0.0, end: -(pi / 2)).animate(
        CurvedAnimation(
            parent: _counterClockWiseController, curve: Curves.bounceOut));

    _counterClockWiseController
      ..reset()
      ..forward.delayed(const Duration(seconds: 1));

    _flipController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _flipAnimation = Tween(begin: 0.0, end: (pi)).animate(
        CurvedAnimation(parent: _flipController, curve: Curves.bounceOut));

    _counterClockWiseController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _flipAnimation = Tween(
                  begin: _flipAnimation.value, end: _flipAnimation.value + (pi))
              .animate(CurvedAnimation(
                  parent: _flipController, curve: Curves.bounceOut));
          _flipController
            ..reset()
            ..forward();
        }
      },
    );

    _flipController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _counterclockwiseanimation = Tween(
                  begin: _counterclockwiseanimation.value,
                  end: _counterclockwiseanimation.value + -(pi / 2))
              .animate(CurvedAnimation(
                  parent: _counterClockWiseController,
                  curve: Curves.bounceOut));

          _counterClockWiseController
            ..reset()
            ..forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _counterClockWiseController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 47, 47),
      body: SafeArea(
        child: Center(
            child: AnimatedBuilder(
                animation: _counterClockWiseController,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateZ(_counterclockwiseanimation.value),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                            animation: _flipController,
                            builder: (context, child) {
                              return Transform(
                                transform: Matrix4.identity()
                                  ..rotateY(_flipAnimation.value),
                                alignment: Alignment.centerRight,
                                child: ClipPath(
                                  clipper: const HalfCircleClipper(
                                      side: CircleSide.left),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4, color: Colors.white),
                                        color: const Color.fromARGB(
                                            255, 161, 19, 9)),
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              );
                            }),
                        AnimatedBuilder(
                            animation: _flipController,
                            builder: (context, child) {
                              return Transform(
                                alignment: Alignment.centerLeft,
                                transform: Matrix4.identity()
                                  ..rotateY(_flipAnimation.value),
                                child: ClipPath(
                                  clipper: const HalfCircleClipper(
                                      side: CircleSide.right),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 12, 67, 112),
                                        border: Border.all(
                                            width: 4, color: Colors.white)),
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  );
                })),
      ),
    );
  }
}
