import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DatamexCameraWidget extends StatefulWidget {
  const DatamexCameraWidget({
    Key? key,
    required this.onImageSelected,
    required this.loadStatusCallback,
    required this.changeStatusMessageCallback,
  }) : super(key: key);
  final Function(File?) onImageSelected;
  final Function(bool) loadStatusCallback;
  final Function(String) changeStatusMessageCallback;
  // Variable para mostrar el mensaje de progreso

  @override
  _DatamexCameraWidgetState createState() => _DatamexCameraWidgetState();
}

class _DatamexCameraWidgetState extends State<DatamexCameraWidget> {
  File? _selectedImageFile;

  /*  Future<File> compressImage(XFile imageFile) async {
    print('akjsdnakjsdnaksjdnasda 😍😍😍');
    widget.loadStatusCallback(true);
    widget.changeStatusMessageCallback('Comprimiendo imágen');
    print('ksjdnasda 😍😍😍');

    final compressedPhoto =
        await ImageUtils.compressAndRotateImage(imageFile, 80);
    // Crear un archivo temporal con los bytes comprimidos
    final compressedPhotoPath = '${imageFile.path}_compressed.jpg';
    final compressedPhotoFile = File(compressedPhotoPath);
    // Compresión con seguimiento de progreso
    return await compressedPhotoFile.writeAsBytes(compressedPhoto, flush: true,
        onWriteProgress: (int bytes, int totalBytes) {
      setState(() {
        _compressionProgress = bytes / totalBytes;
      });
    });
    //await compressedPhotoFile.writeAsBytes(compressedPhoto);
  } */
  void _printImageSize(XFile? image, String label) {
    if (image != null) {
      final imageSize = File(image.path).lengthSync();
      print('$label: ${(imageSize / 1024).toStringAsFixed(2)} KB');
    }
  }

  Future<void> _takePhoto() async {
    widget.changeStatusMessageCallback('Abriendo cámara');
    widget.loadStatusCallback(true);
    final picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    /* final image100 =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    final image50 =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    final image25 =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    final image10 =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 10); */
    /* if (image100 != null &&
        image50 != null &&
        image25 != null &&
        image10 != null) {
      _printImageSize(image100, 'Image Quality 100');
      _printImageSize(image50, 'Image Quality 50');
      _printImageSize(image25, 'Image Quality 25');
      _printImageSize(image10, 'Image Quality 10');
    } */
    if (image != null) {
      widget.changeStatusMessageCallback('Comprimiendo imágen');
      // Realizar la compresión en segundo plano con un retraso mínimo para permitir la actualización de la interfaz de usuario
      await Future.delayed(const Duration(milliseconds: 100), () async {
        /* final compressedImageFile = await compressImage(XFile(image.path)); */
        setState(() {
          _selectedImageFile = File(image.path);
        });
      });

      // Llama a la función de devolución de llamada con el archivo capturado
      widget.onImageSelected(_selectedImageFile);
      widget.loadStatusCallback(false);
    } else {
      widget.loadStatusCallback(
          false); // Finalizar la carga si no se capturó ninguna imagen
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

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
