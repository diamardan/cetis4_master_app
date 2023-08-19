import 'package:datamex_master_app/app/data/services/remote/preregistrations.service.dart';
import 'package:datamex_master_app/app/domain/models/preregistration.dart';
import 'package:datamex_master_app/app/presentation/global/dialogs/datamex_notification_dialog_widget.dart';
import 'package:datamex_master_app/app/presentation/global/painters/my_custom_painter.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_delete_confirmation.dart';
import 'package:datamex_master_app/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class IndexPreregistrations extends StatefulWidget {
  const IndexPreregistrations({Key? key}) : super(key: key);

  @override
  State<IndexPreregistrations> createState() => _IndexPreregistrationsState();
}

class _IndexPreregistrationsState extends State<IndexPreregistrations> {
  List<PreregistrationModel> _preregistrations = [];
  final PreregistrationsService _preregistrationsService =
      PreregistrationsService();
  bool isLoading = false;
  bool showList = false;

  @override
  void initState() {
    // TODO: implement initState
    _loadPreregistrations();
    showLoading(true);
  }

  showLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  showAsList() {
    setState(() {
      showList = !showList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Preregistros'),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadPreregistrations,
          child: CustomPaint(
            painter: MiCustomPainter(),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Routes.goToRoute(context, Routes.addPreregistrations);
                      },
                      child: const Text('Agregar'),
                    ),
                    SizedBox(
                      width: 60,
                      child: MaterialButton(
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            showList = !showList; // Cambia entre las dos vistas
                          });
                        },
                        child: const Icon(Icons.view_list),
                      ),
                    ),
                  ],
                ),
                if (isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.blue.shade500,
                            backgroundColor: Colors.blue.shade700,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            'Cargando datos!',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (showList)
                  preregistrationsWidgetList()
                else
                  Expanded(
                    child: SingleChildScrollView(
                      physics:
                          const AlwaysScrollableScrollPhysics(), // Permitir el desplazamiento incluso cuando el contenido no lo requiere
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: preregistrationsWidgetTable(),
                      ),
                    ),
                  ),
                /* Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: !isLoading
                          ? SingleChildScrollView(
                              child: preregistrationsWidgetTable())
                          : Container(
                              color: Colors.black.withOpacity(0.3),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                        color: Colors.blue.shade500,
                                        backgroundColor: Colors.blue.shade700),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    const Text(
                                      'Cargando datos!',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ), */
              ],
            ),
            /* Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(child: preregistrationsWidgetTable()),
                  ),
                ),
              ) */
          ),
        ),
      ),
    );
  }

  Widget preregistrationsWidgetList() {
    return _preregistrations.isEmpty
        ? const Center(
            child: Text(
            'Aún no hay registros',
            style: TextStyle(fontSize: 23),
          ))
        : Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _preregistrations.length,
              itemBuilder: (context, index) {
                // Obtener el índice en la lista original de registros
/*                 int originalIndex = index % _preregistrations.length;
 */
                final preregistration = _preregistrations[index];
                return Card(
                  child: ListTile(
                    title: Text(
                        '${preregistration.surnames} ${preregistration.names}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(preregistration.career.name),
                        Row(
                          children: [
                            Text('${preregistration.grade.name}  -  '),
                            Text('${preregistration.group.name}  -  '),
                            Text(preregistration.turn.name),
                          ],
                        )
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            bool? deleteConfirmed =
                                await const DatamexDeleteConfirmationDialog(
                              title: 'Confirmación de Eliminación',
                              message:
                                  '¿Estás seguro de que deseas eliminar este registro?',
                            ).show(context);

                            if (deleteConfirmed ?? false) {
                              showLoading(true);
                              Map<String, dynamic> result =
                                  await _preregistrationsService
                                      .delete(preregistration.id);
                              String message = result['message'];
                              print('🤮👍');
                              print(message);
                              showLoading(true);
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
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget preregistrationsWidgetTable() {
    print('😁😁😁');
    return _preregistrations.isEmpty
        ? const Center(
            child: /* CircularProgressIndicator() */
                Text(
            'Aún no hay preregistros',
            style: TextStyle(fontSize: 23),
          ))
        : Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Añadir scroll horizontal
                  child: DataTable(
                    columnSpacing: 1,
                    border: TableBorder.all(color: Colors.black87),
                    columns: const [
                      DataColumn(
                        label: Text('Fecha'),
                      ),
                      DataColumn(
                        label: Text('Hora'),
                      ),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text('Apellidos'),
                      )),
                      DataColumn(
                        label: Text('Nombres'),
                      ),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text('C.U.R.P.'),
                      )),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text('Carrera'),
                      )),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text('Grado'),
                      )),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text('Grupo'),
                      )),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text('Turno'),
                      )),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text('Acciones'),
                      )),
                    ],
                    rows: _preregistrations.map((preregistration) {
                      return DataRow(cells: [
                        DataCell(SizedBox(
                            child: Center(
                                child: Text('${preregistration.fecha}')))),
                        DataCell(SizedBox(
                            child: Center(
                                child: Text('${preregistration.hora}')))),
                        DataCell(Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: SizedBox(
                              width: 200,
                              child: Text(preregistration.surnames)),
                        )),
                        DataCell(SizedBox(
                            child: Center(child: Text(preregistration.names)))),
                        DataCell(Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: SizedBox(
                              width: 200, child: Text(preregistration.curp)),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: SizedBox(
                              width: 200,
                              child: Text(preregistration.career.name)),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: SizedBox(
                              width: 200,
                              child: Text(preregistration.grade.name)),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: SizedBox(
                              width: 200,
                              child: Text(preregistration.group.name)),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: SizedBox(
                              width: 200,
                              child: Text(preregistration.turn.name)),
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
                                      '¿Estás seguro de que deseas eliminar este preregistro?',
                                ).show(context);

                                if (deleteConfirmed ?? false) {
                                  showLoading(true);
                                  Map<String, dynamic> result =
                                      await _preregistrationsService
                                          .delete(preregistration.id);
                                  String message = result['message'];
                                  print('🤮👍');
                                  print(message);
                                  showLoading(false);
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
                  )),
            ),
          );
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
                  _loadPreregistrations();
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadPreregistrations() async {
    try {
      showLoading(true);
      List<PreregistrationModel> preregistrations =
          await _preregistrationsService.getPreregistrations();
      setState(() {
        _preregistrations = preregistrations;
      });
      print('🎶🎶🎶🎶👍');
      print(_preregistrations);
      showLoading(false);
    } catch (e) {
      print('Error fetching preregistrations: $e');
      showLoading(false);

      // Maneja el error apropiadamente
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return NotificationDialogWidget(
            message: 'Hubo un error al cargar los preregistros.',
            onConfirm: () {
              Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
            },
          );
        },
      );
    }
  }
}
