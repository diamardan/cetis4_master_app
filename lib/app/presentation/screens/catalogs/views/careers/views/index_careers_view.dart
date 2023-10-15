import 'package:cetis4_master_app/app/data/services/remote/careers.service.dart';
import 'package:cetis4_master_app/app/domain/models/careers.dart';
import 'package:cetis4_master_app/app/presentation/global/painters/my_custom_painter.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_delete_confirmation.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_index_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../global/dialogs/datamex_notification_dialog_widget.dart';
import '../../../../../routes/routes.dart';

class IndexCareers extends StatefulWidget {
  const IndexCareers({Key? key}) : super(key: key);

  @override
  State<IndexCareers> createState() => _IndexCareersState();
}

class _IndexCareersState extends State<IndexCareers> {
  List<CareerModel> _careers = [];
  final CareersService _careersProvider = CareersService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCareers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Carreras'),
      body: CustomPaint(
        painter: MiCustomPainter(),
        child: DatamexIndexMenu(children: [
          ElevatedButton(
              onPressed: () {
                Routes.goToRoute(context, Routes.addCareer);
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
                child: SingleChildScrollView(child: carrerasWidgetTable()),
              ),
            ),
          )
        ]),
        /* Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(child: carrerasWidgetTable()),
              ),
            ),
          ) */
      ),
    );
  }

  Widget carrerasWidgetTable() {
    print('😁😁😁');
    return _careers.isEmpty
        ? const Center(
            child: /* CircularProgressIndicator() */
                Text(
            'Aún no hay carreras',
            style: TextStyle(fontSize: 23),
          ))
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Añadir scroll horizontal
            child: SizedBox(
              child: DataTable(
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
                rows: _careers.map((career) {
                  return DataRow(cells: [
                    /* DataCell(SizedBox(
                        child: Center(child: Text(career.id.toString())))), */
                    DataCell(Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(width: 200, child: Text(career.name)),
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
                                  await _careersProvider.delete(career.id);
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
                  _loadCareers();
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadCareers() async {
    try {
      List<CareerModel> careers = await _careersProvider.getCareers();
      setState(() {
        _careers = careers;
      });
      print('🎶🎶🎶🎶👍');
      print(_careers);
    } catch (e) {
      print('Error fetching careers: $e');
      // Maneja el error apropiadamente
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return NotificationDialogWidget(
            message: 'Hubo un error al cargar los careers.',
            onConfirm: () {
              Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
            },
          );
        },
      );
    }
  }
}
