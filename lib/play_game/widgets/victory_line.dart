import 'package:flutter/material.dart';
import 'package:tic_tac_toe/play_game/model/victory.dart';

class VictoryLine extends StatelessWidget {
  final Victory victory;

  const VictoryLine({
    Key? key,
    required this.victory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: VictoryLinePainter(victory: victory));
  }
}

class VictoryLinePainter extends CustomPainter {
  Victory victory;

  VictoryLinePainter({required this.victory});

  @override
  bool hitTest(Offset position) {
    return false;
  }

  final _paint = Paint()
    ..color = Colors.white
    ..strokeWidth = 7.0
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    if (victory.winner != Winner.none) {
      if (victory.lineType == LineType.horizontal) {
        _drawHorizontalLine(victory.row, size, canvas);
      } else if (victory.lineType == LineType.vertical) {
        _drawVerticalLine(victory.col, size, canvas);
      } else if (victory.lineType == LineType.diagonal_ascending) {
        _drawDiagonalLine(true, size, canvas);
      } else if (victory.lineType == LineType.diagonal_descending) {
        _drawDiagonalLine(false, size, canvas);
      }
    }
  }

  void _drawVerticalLine(int column, Size size, Canvas canvas) {
    if (column == 0) {
      var x = size.width / 3 / 2;
      var top = Offset(x, 8.0);
      var bottom = Offset(x, size.height - 8.0);
      canvas.drawLine(top, bottom, _paint);
    } else if (column == 1) {
      var x = size.width / 2;
      var top = Offset(x, 8.0);
      var bottom = Offset(x, size.height - 8.0);
      canvas.drawLine(top, bottom, _paint);
    } else {
      var columnWidth = size.width / 3;
      var x = columnWidth * 2 + columnWidth / 2;
      var top = Offset(x, 8.0);
      var bottom = Offset(x, size.height - 8.0);
      canvas.drawLine(top, bottom, _paint);
    }
  }

  void _drawHorizontalLine(int row, Size size, Canvas canvas) {
    if (row == 0) {
      var y = size.height / 3 / 2;
      var left = Offset(8.0, y);
      var right = Offset(size.width - 8.0, y);
      canvas.drawLine(left, right, _paint);
    } else if (row == 1) {
      var y = size.height / 2;
      var left = Offset(8.0, y);
      var right = Offset(size.width - 8.0, y);
      canvas.drawLine(left, right, _paint);
    } else {
      var columnHeight = size.height / 3;
      var y = columnHeight * 2 + columnHeight / 2;
      var left = Offset(8.0, y);
      var right = Offset(size.width - 8.0, y);
      canvas.drawLine(left, right, _paint);
    }
  }

  void _drawDiagonalLine(bool isAscending, Size size, Canvas canvas) {
    if (isAscending) {
      var bottomLeft = Offset(8.0, size.height - 8.0);
      var topRight = Offset(size.width - 8.0, 8.0);
      canvas.drawLine(bottomLeft, topRight, _paint);
    } else {
      var topLeft = const Offset(8.0, 8.0);
      var bottomRight = Offset(size.width - 8.0, size.height - 8.0);
      canvas.drawLine(topLeft, bottomRight, _paint);
    }
  }

  @override
  bool shouldRepaint(VictoryLinePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(VictoryLinePainter oldDelegate) => false;
}
