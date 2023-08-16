import 'package:flutter/material.dart';

class DatamexTextPainterWidget extends CustomPainter {
  DatamexTextPainterWidget({
    required this.text,
    required this.fontSize,
    required this.textColor,
    required this.fontFamily,
  });
  final String text;
  final double fontSize;
  final Color textColor;
  final String fontFamily;

  @override
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontFamily: fontFamily,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final xOffset = (size.width - textPainter.width) / 2;
    final yOffset = (size.height - textPainter.height) / 2;

    final offset = Offset(xOffset, yOffset);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
