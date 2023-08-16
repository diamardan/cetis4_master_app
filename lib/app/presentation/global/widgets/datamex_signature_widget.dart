import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class DatamexSignaturePad extends StatefulWidget {
  const DatamexSignaturePad({Key? key, required this.controller})
      : super(key: key);
  @override
  State<DatamexSignaturePad> createState() => _DatamexSignaturePadState();
  final SignatureController controller;
}

class _DatamexSignaturePadState extends State<DatamexSignaturePad> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Signature(
              dynamicPressureSupported: true,
              controller: widget.controller,
              height: 120,
              width: MediaQuery.of(context).size.width * .90,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: MaterialButton(
                  color: Colors.red.shade800,
                  onPressed: () {
                    widget.controller.clear();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.undo,
                        color: Colors.white,
                      ),
                      Text(
                        'Deshacer firma',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
