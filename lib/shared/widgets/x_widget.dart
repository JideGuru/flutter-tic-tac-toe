import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tic_tac_toe/app.dart';

class XWidget extends HookWidget {
  final double height;
  final double width;
  final bool shouldAnimate;
  final Color color;
  final double strokeWidth;

  const XWidget({
    Key? key,
    this.height = 100,
    this.width = 100,
    this.shouldAnimate = true,
    this.color = yellow,
    this.strokeWidth = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    final secondAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    useEffect(() {
      firstAnimationController.forward();
      firstAnimationController.addListener(() {
        if (firstAnimationController.value == 1) {
          secondAnimationController.forward();
        }
      });
      return () {};
    }, []);
    return SizedBox(
      height: height,
      width: width,
      child: AnimatedBuilder(
        animation: Listenable.merge(
          [firstAnimationController, secondAnimationController],
        ),
        builder: (context, child) {
          return CustomPaint(
            painter: XPainter(
              color: color,
              firstLineProgress:
                  shouldAnimate ? firstAnimationController.value : 1,
              secondLineProgress:
                  shouldAnimate ? secondAnimationController.value : 1,
              strokeWidth: strokeWidth,
            ),
          );
        },
      ),
    );
  }
}

class XPainter extends CustomPainter {
  final Color color;
  final double firstLineProgress;
  final double secondLineProgress;
  final double strokeWidth;

  XPainter({
    required this.color,
    this.firstLineProgress = 1,
    this.secondLineProgress = 1,
    this.strokeWidth = 30,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    Path firstPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height);

    Path secondPath = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, size.height);
    animatePath(firstPath, paint, canvas, firstLineProgress);
    if (firstLineProgress == 1) {
      animatePath(secondPath, paint, canvas, secondLineProgress);
    }
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
  bool shouldRepaint(covariant XPainter oldDelegate) {
    return oldDelegate.firstLineProgress != firstLineProgress ||
        oldDelegate.secondLineProgress != secondLineProgress;
  }
}
