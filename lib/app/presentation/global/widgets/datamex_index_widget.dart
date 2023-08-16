import 'package:flutter/material.dart';

class DatamexIndexMenu extends StatelessWidget {
  const DatamexIndexMenu({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: children),
      ),
    );
  }
}
