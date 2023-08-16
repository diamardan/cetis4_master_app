import 'package:flutter/material.dart';

class CardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cardWidth = size.width;
    final double cardHeight = size.height;
    final double cardX = (size.width - cardWidth) / 2;
    final double cardY = (size.height - cardHeight) / 2;

    final Rect rect =
        Rect.fromLTRB(cardX, cardY, cardX + cardWidth, cardY + cardHeight);
    final Paint paint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0
      ..shader = const LinearGradient(
        colors: [Colors.white, Colors.white70],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);

    final RRect roundedRect =
        RRect.fromRectAndRadius(rect, const Radius.circular(20));
    canvas.drawRRect(roundedRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
