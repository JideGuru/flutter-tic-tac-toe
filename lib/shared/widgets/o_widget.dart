import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tic_tac_toe/app.dart';

class OWidget extends HookWidget {
  final double height;
  final double width;
  final bool shouldAnimate;
  final Color color;
  final double radius;
  final double strokeWidth;

  const OWidget({
    Key? key,
    this.height = 100,
    this.width = 100,
    this.shouldAnimate = true,
    this.color = yellow,
    this.radius = 55,
    this.strokeWidth = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 600));
    final animation = Tween<double>(begin: 0, end: math.pi * 2).animate(
      animationController,
    );

    useEffect(() {
      animationController.forward();
      return () {};
    }, []);
    return SizedBox(
      height: height,
      width: width,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return CustomPaint(
            painter: OPainter(
              color: color,
              sweepAngle: shouldAnimate ? animation.value : math.pi * 2,
              radius: radius,
              strokeWidth: strokeWidth
            ),
          );
        },
      ),
    );
  }
}

class OPainter extends CustomPainter {
  final Color color;
  final double sweepAngle;
  final double radius;
  final double strokeWidth;

  OPainter({
    required this.color,
    required this.sweepAngle,
    this.radius = 55,
    this.strokeWidth = 30,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Rect rect =
        Rect.fromCircle(center: size.center(Offset.zero), radius: radius);
    canvas.drawArc(rect, 0, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant OPainter oldDelegate) {
    return oldDelegate.sweepAngle != sweepAngle;
  }
}
