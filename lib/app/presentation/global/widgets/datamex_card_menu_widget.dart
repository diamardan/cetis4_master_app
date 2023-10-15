import 'package:cetis4_master_app/app/presentation/global/painters/my_custom_painter.dart';
import 'package:flutter/material.dart';

class DatamexCardMenu extends StatelessWidget {
  const DatamexCardMenu({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomPaint(
        painter: MiCustomPainter(),
        child: SizedBox(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Wrap(
                    spacing: 3,
                    runSpacing: 3,
                    runAlignment: WrapAlignment.start,
                    children: children),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
