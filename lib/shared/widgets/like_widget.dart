import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tic_tac_toe/app.dart';

class LikeWidget extends HookWidget {
  final double height;
  final double width;
  final bool shouldAnimate;
  final Color color;
  final double radius;
  final double strokeWidth;

  const LikeWidget({
    Key? key,
    this.height = 100,
    this.width = 100,
    this.shouldAnimate = true,
    this.color = yellow,
    this.radius = 55,
    this.strokeWidth = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 600));
    final animation = Tween<double>(begin: 0, end: 1).animate(
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
            painter: LikePainter(
              color: color,
              progress: shouldAnimate ? animation.value : 1,
              radius: radius,
              strokeWidth: strokeWidth,
            ),
          );
        },
      ),
    );
  }
}

class LikePainter extends CustomPainter {
  final Color color;
  final double progress;
  final double radius;
  final double strokeWidth;

  LikePainter({
    required this.color,
    required this.progress,
    this.radius = 55,
    this.strokeWidth = 20,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.close();

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.6083333, size.height * 0.3333333);
    path_1.lineTo(size.width * 0.8750000, size.height * 0.3333333);
    path_1.arcToPoint(Offset(size.width * 0.9583333, size.height * 0.4166667),
        radius: Radius.elliptical(
            size.width * 0.08333333, size.height * 0.08333333),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.9583333, size.height * 0.5043333);
    path_1.arcToPoint(Offset(size.width * 0.9520833, size.height * 0.5360833),
        radius: Radius.elliptical(
            size.width * 0.08333333, size.height * 0.08333333),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.8231250, size.height * 0.8492083);
    path_1.arcToPoint(Offset(size.width * 0.7845833, size.height * 0.8750000),
        radius: Radius.elliptical(
            size.width * 0.04166667, size.height * 0.04166667),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.08333333, size.height * 0.8750000);
    path_1.arcToPoint(Offset(size.width * 0.04166667, size.height * 0.8333333),
        radius: Radius.elliptical(
            size.width * 0.04166667, size.height * 0.04166667),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.04166667, size.height * 0.4166667);
    path_1.arcToPoint(Offset(size.width * 0.08333333, size.height * 0.3750000),
        radius: Radius.elliptical(
            size.width * 0.04166667, size.height * 0.04166667),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.2284167, size.height * 0.3750000);
    path_1.arcToPoint(Offset(size.width * 0.2624583, size.height * 0.3573750),
        radius: Radius.elliptical(
            size.width * 0.04166667, size.height * 0.04166667),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.lineTo(size.width * 0.4896667, size.height * 0.03541667);
    path_1.arcToPoint(Offset(size.width * 0.5160000, size.height * 0.02879167),
        radius: Radius.elliptical(
            size.width * 0.02083333, size.height * 0.02083333),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.5915833, size.height * 0.06658333);
    path_1.arcToPoint(Offset(size.width * 0.6459583, size.height * 0.1854583),
        radius:
            Radius.elliptical(size.width * 0.1041667, size.height * 0.1041667),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.6083333, size.height * 0.3333333);
    path_1.close();
    path_1.moveTo(size.width * 0.25, size.height * 0.38);
    path_1.lineTo(size.width * 0.25, size.height * 0.90);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff000000).withOpacity(1.0);
    animatePath(path_1, paint, canvas, progress);
  }

  animatePath(Path path, Paint paint, Canvas canvas, double progress) {
    PathMetrics shadowMetrics = path.computeMetrics();
    for (PathMetric pathMetric in shadowMetrics) {
      Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * progress,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant LikePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
