import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DatamexCameraWidget extends StatefulWidget {
  const DatamexCameraWidget({Key? key, required this.onImageSelected})
      : super(key: key);
  final Function(File?) onImageSelected;

  @override
  _DatamexCameraWidgetState createState() => _DatamexCameraWidgetState();
}

class _DatamexCameraWidgetState extends State<DatamexCameraWidget> {
  File? _selectedImageFile;

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _selectedImageFile = File(image.path);
      });

      // Llama a la función de devolución de llamada con el archivo capturado
      widget.onImageSelected(_selectedImageFile);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImageFile = File(image.path);
      });

      // Llama a la función de devolución de llamada con el archivo seleccionado
      widget.onImageSelected(_selectedImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_selectedImageFile == null)
          const Text(
              'Presiona el botón para tomar una foto o elegir una imagen.'),
        if (_selectedImageFile != null) Image.file(_selectedImageFile!),
        ElevatedButton(
          onPressed: _takePhoto,
          child: const Text('Tomar Foto'),
        ),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Elegir Imagen'),
        ),
      ],
    );
  }
}
