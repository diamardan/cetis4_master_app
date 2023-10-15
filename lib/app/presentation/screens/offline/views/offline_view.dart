import 'package:cetis4_master_app/app/presentation/global/painters/background_painter.dart';
import 'package:flutter/material.dart';

class OfflineView extends StatelessWidget {
  const OfflineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
          painter: BackgroundPainter(),
          child: const Center(child: Text('Offline Screen'))),
    );
  }
}
