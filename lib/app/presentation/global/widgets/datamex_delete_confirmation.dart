import 'package:flutter/material.dart';

class DatamexDeleteConfirmationDialog extends StatelessWidget {
  const DatamexDeleteConfirmationDialog(
      {super.key,
      /* required this.onPressed, */
      required this.title,
      required this.message});
  /* final VoidCallback onPressed; */
  final String title;
  final String message;

  Future<bool?> show(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  /* onPressed(); */
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  'Eliminar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
