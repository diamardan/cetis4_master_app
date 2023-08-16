import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;
    // Altura del rectángulo
    double rectangleHeight = size.height / 3;
    // Definir los vértices del rectángulo
    Offset p1 = const Offset(0, 0);
    Offset p2 = Offset(size.width, 0);
    Offset p3 = Offset(size.width, rectangleHeight - 20);
    Offset p4 = Offset(0, rectangleHeight);

    // Radio de las esquinas redondeadas
    double cornerRadius = 140.0;
    // Dibujar las líneas para trazar el rectángulo
    // Dibujar el rectángulo relleno
    Path path = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy - cornerRadius)
      ..quadraticBezierTo(p3.dx, p3.dy, p3.dx - cornerRadius, p3.dy)
      ..lineTo(p4.dx + cornerRadius, p4.dy) // Curva negativa aquí
      ..quadraticBezierTo(
          p4.dx, p4.dy, p4.dx, p4.dy + cornerRadius) // Curva negativa interna
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
