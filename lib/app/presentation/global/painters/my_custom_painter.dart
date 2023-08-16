import 'dart:math';

import 'package:flutter/material.dart';

class MiCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.blue.shade100;
    const double amplitude = 40;
    final double frequency = 2.0 * pi / size.width;
    const double phase = pi / 2.0; // To start the wave from the top

    Path path = Path();
    path.moveTo(0, size.height / 2);

    for (double x = 0; x < size.width; x += 1) {
      final double y =
          size.height / 1.2 + amplitude * sin(frequency * x + phase);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // Devuelve true si quieres que el lienzo se redibuje (por ejemplo, si los datos han cambiado)
    return false;
  }
}
