import 'package:datamex_master_app/app/data/services/remote/grades.service.dart';
import 'package:datamex_master_app/app/domain/models/grades.dart';
import 'package:datamex_master_app/app/presentation/global/painters/my_custom_painter.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_delete_confirmation.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_index_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../global/dialogs/datamex_notification_dialog_widget.dart';
import '../../../../../routes/routes.dart';

class IndexGrades extends StatefulWidget {
  const IndexGrades({Key? key}) : super(key: key);

  @override
  State<IndexGrades> createState() => _IndexGradesState();
}

class _IndexGradesState extends State<IndexGrades> {
  List<GradesModel> _grades = [];
  final GradesService _gradesProvider = GradesService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadGrades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Grados'),
      body: CustomPaint(
        painter: MiCustomPainter(),
        child: DatamexIndexMenu(children: [
          ElevatedButton(
              onPressed: () {
                Routes.goToRoute(context, Routes.addGrade);
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
                child: SingleChildScrollView(child: gradosWidgetTable()),
              ),
            ),
          )
        ]),
        /* Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(child: gradosWidgetTable()),
              ),
            ),
          ) */
      ),
    );
  }

  Widget gradosWidgetTable() {
    print('😁😁😁');
    return _grades.isEmpty
        ? const Center(
            child: /* CircularProgressIndicator() */
                Text(
            'Aún no hay grados',
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
                rows: _grades.map((grade) {
                  return DataRow(cells: [
                    /*  DataCell(SizedBox(
                        child: Center(child: Text(grade.id.toString())))),
                     */
                    DataCell(Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(width: 200, child: Text(grade.name)),
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
                                    '¿Estás seguro de que deseas eliminar este grado?',
                              ).show(context);

                              if (deleteConfirmed ?? false) {
                                Map<String, dynamic> result =
                                    await _gradesProvider.delete(grade.id);
                                String message = result['message'];
                                print('🤮👍');
                                print(message);
                                _showMessageDialog(message);
                              }
                            })
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
                  _loadGrades();
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadGrades() async {
    try {
      List<GradesModel> grades = await _gradesProvider.getGrades();
      setState(() {
        _grades = grades;
      });
      print('🎶🎶🎶🎶👍');
      print(_grades);
    } catch (e) {
      print('Error fetching grades: $e');
      // Maneja el error apropiadamente
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return NotificationDialogWidget(
            message: 'Hubo un error al cargar los grades.',
            onConfirm: () {
              Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
            },
          );
        },
      );
    }
  }
}
