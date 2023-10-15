import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cetis4_master_app/app/presentation/global/painters/datamex_text_painter.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DatamexTextToImageConverter extends StatefulWidget {
  DatamexTextToImageConverter({
    Key? key,
    required this.fontFamily,
    required this.fontSize,
    required this.textColor,
    required this.scaffoldContext,
    required this.text,
  }) : super(key: key);
  String fontFamily = 'Roboto';
  final double fontSize;
  final Color textColor;
  final BuildContext scaffoldContext; // Agregar scaffoldContext como parámetro
  final String text;
  @override
  _DatamexTextToImageConverterState createState() =>
      _DatamexTextToImageConverterState();
}

class _DatamexTextToImageConverterState
    extends State<DatamexTextToImageConverter> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey _imageKey = GlobalKey();
  ui.Image? _generatedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _textEditingController,
          decoration: const InputDecoration(labelText: 'Enter Text'),
          onChanged: (value) {
            // Handle onChanged if needed
          },
        ),
        const SizedBox(height: 20),
        /* RepaintBoundary(
          key: _imageKey,
          child: Builder(
            builder: (context) {
              return CustomPaint(
                painter: DatamexTextPainterWidget(
                  text: _textEditingController.text,
                  fontSize: widget.fontSize,
                  textColor: widget.textColor,
                  fontFamily: widget.fontFamily,
                ),
              );
            },
          ),
        ), */
        ElevatedButton(
          onPressed: () {
            _generateAndSaveImage();
          },
          child: const Text('Generate and Save Image'),
        ),
        _generatedImage != null
            ? FutureBuilder<Uint8List>(
                future: _imageToByteList(_generatedImage!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Image.memory(snapshot.data!);
                  } else {
                    return const SizedBox();
                  }
                },
              )
            : const SizedBox(),
      ],
    );
  }

  Future<void> _generateAndSaveImage() async {
    ui.Image image = await _getImageFromCustomPainter();
    setState(() {
      _generatedImage = image;
    });

    await _saveImageToFile(image);
  }

  Future<ui.Image> _getImageFromCustomPainter() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    DatamexTextPainterWidget(
      text: _textEditingController.text,
      fontSize: widget.fontSize,
      textColor: widget.textColor,
      fontFamily: 'BrushScriptMT',
    ).paint(canvas, const Size(300, 100)); // Adjust the size as needed

    final picture = recorder.endRecording();
    final image = await picture.toImage(300, 100); // Adjust the size as needed
    return image;
  }

  Future<Uint8List> _imageToByteList(ui.Image image) async {
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception('Failed to convert image to byte data');
    }
    return byteData.buffer.asUint8List();
  }

  Future<void> _saveImageToFile(ui.Image image) async {
    final Uint8List uint8List = await _imageToByteList(image);

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/generated_image.png';

    File file = File(filePath);
    await file.writeAsBytes(uint8List);

    ScaffoldMessenger.of(widget.scaffoldContext).showSnackBar(
      SnackBar(content: Text('Image saved at $filePath')),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
