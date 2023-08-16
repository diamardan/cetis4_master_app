import 'package:flutter/material.dart';

class DatamexFormButton extends StatefulWidget {
  DatamexFormButton({
    Key? key,
    required this.color,
    required this.onPress,
    required this.label,
    this.textColor,
  }) : super(key: key);

  final Color color;
  final void Function() onPress;
  final String label;
  Color? textColor;
  @override
  State<DatamexFormButton> createState() => _DatamexFormButtonState();
}

class _DatamexFormButtonState extends State<DatamexFormButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: widget.color,
      onPressed: widget.onPress,
      child: SizedBox(
        height: 35,
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(color: widget.textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
