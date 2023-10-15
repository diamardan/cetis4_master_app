import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DatamexQuillEditor extends StatefulWidget {
  const DatamexQuillEditor({super.key});

  @override
  _DatamexQuillEditorState createState() => _DatamexQuillEditorState();
}

class _DatamexQuillEditorState extends State<DatamexQuillEditor> {
  QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = QuillController(
      document: Document()..insert(0, 'Initial text.'),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: QuillEditor(
              scrollController: _scrollController,
              scrollable: false,
              controller: _controller,
              readOnly: false,
              autoFocus: false,
              focusNode: _focusNode,
              expands: true,
              padding: EdgeInsets.zero,
              placeholder: 'Escribe aquí...',
            ),
          ),
        ),
        // Botón para adjuntar archivos
        ElevatedButton(
          onPressed: () {
            // Implementa la lógica para adjuntar archivos aquí
          },
          child: Container(),
        ),
      ],
    );
  }
}
