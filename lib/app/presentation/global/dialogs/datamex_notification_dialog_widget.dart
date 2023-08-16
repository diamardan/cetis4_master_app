import 'package:flutter/material.dart';

class NotificationDialogWidget extends StatelessWidget {
  const NotificationDialogWidget(
      {super.key, required this.onConfirm, required this.message});
  final VoidCallback onConfirm;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Aviso'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Cerrar el cuadro de diálogo
            onConfirm(); // Llamar a la función de confirmación
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
