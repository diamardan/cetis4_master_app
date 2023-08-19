import 'package:datamex_master_app/app/data/services/remote/turns.service.dart';
import 'package:datamex_master_app/app/domain/models/turns.dart';
import 'package:datamex_master_app/app/presentation/global/painters/my_custom_painter.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_delete_confirmation.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_index_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../global/dialogs/datamex_notification_dialog_widget.dart';
import '../../../../../routes/routes.dart';

class IndexTurns extends StatefulWidget {
  const IndexTurns({Key? key}) : super(key: key);

  @override
  State<IndexTurns> createState() => _IndexTurnsState();
}

class _IndexTurnsState extends State<IndexTurns> {
  List<TurnsModel> _turns = [];
  final TurnsService _turnsProvider = TurnsService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTurns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Turnos'),
      body: CustomPaint(
        painter: MiCustomPainter(),
        child: DatamexIndexMenu(children: [
          ElevatedButton(
              onPressed: () {
                Routes.goToRoute(context, Routes.addTurn);
              },
              child: const Text('Agregar')),
          const SizedBox(
            height: 10,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(child: turnosWidgetTable()),
              ),
            ),
          )
        ]),
        /* Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(child: turnosWidgetTable()),
              ),
            ),
          ) */
      ),
    );
  }

  Widget turnosWidgetTable() {
    print('😁😁😁');
    return _turns.isEmpty
        ? const Center(
            child: /* CircularProgressIndicator() */
                Text(
            'Aún no hay turnos',
            style: TextStyle(fontSize: 23),
          ))
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Añadir scroll horizontal
            child: SizedBox(
              child: DataTable(
                dataRowMaxHeight: 50,
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey.shade100),
                columnSpacing: 1,
                border: TableBorder.all(color: Colors.black87),
                columns: const [
                  /* DataColumn(
                    label: Text('ID'),
                  ), */
                  DataColumn(
                      label: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text('Nombre'),
                  )),
                  DataColumn(
                      label: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text('Acciones'),
                  )),
                ],
                rows: _turns.map((turn) {
                  return DataRow(cells: [
                    /* DataCell(SizedBox(
                        child: Center(child: Text(turn.id.toString())))), */
                    DataCell(Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(width: 200, child: Text(turn.name)),
                    )),
                    DataCell(Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          height: 40,
                          minWidth: 40,
                          onPressed: () async {
                            bool? deleteConfirmed =
                                await const DatamexDeleteConfirmationDialog(
                              title: 'Confirmación de Eliminación',
                              message:
                                  '¿Estás seguro de que deseas eliminar esta carrera?',
                            ).show(context);

                            if (deleteConfirmed ?? false) {
                              Map<String, dynamic> result =
                                  await _turnsProvider.delete(turn.id);
                              String message = result['message'];
                              print('🤮👍');
                              print(message);
                              _showMessageDialog(message);
                            }
                          },
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ));
  }

  void _showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mensaje'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _loadTurns();
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadTurns() async {
    try {
      List<TurnsModel> turns = await _turnsProvider.getTurns();
      setState(() {
        _turns = turns;
      });
      print('🎶🎶🎶🎶👍');
      print(_turns);
    } catch (e) {
      print('Error fetching turns: $e');
      // Maneja el error apropiadamente
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return NotificationDialogWidget(
            message: 'Hubo un error al cargar los turns.',
            onConfirm: () {
              Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
            },
          );
        },
      );
    }
  }
}
