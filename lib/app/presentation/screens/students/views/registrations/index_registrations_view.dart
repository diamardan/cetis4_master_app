import 'package:datamex_master_app/app/data/services/remote/registrations.service.dart';
import 'package:datamex_master_app/app/domain/models/registration.dart';
import 'package:datamex_master_app/app/presentation/global/dialogs/datamex_notification_dialog_widget.dart';
import 'package:datamex_master_app/app/presentation/global/painters/my_custom_painter.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_delete_confirmation.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_index_widget.dart';
import 'package:datamex_master_app/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class IndexRegistrations extends StatefulWidget {
  const IndexRegistrations({Key? key}) : super(key: key);

  @override
  State<IndexRegistrations> createState() => _IndexRegistrationsState();
}

class _IndexRegistrationsState extends State<IndexRegistrations> {
  List<RegistrationModel> _registrations = [];
  final RegistrationsService _registrationsService = RegistrationsService();
  bool isLoading = false;
  bool showList = true;
  @override
  void initState() {
    // TODO: implement initState
    _loadRegistrations();
    showLoading(true);
  }

  showAsList() {
    setState(() {
      showList = !showList;
    });
  }

  showLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Registros'),
      body: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              CustomPaint(
                painter: MiCustomPainter(),
                size: MediaQuery.of(context).size,
              ),
              DatamexIndexMenu(children: [
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Routes.goToRoute(context, Routes.addRegistrations);
                        },
                        child: const Text('Agregar')),
                    SizedBox(
                      width: 60,
                      child: MaterialButton(
                          color: Colors.white,
                          onPressed: () {
                            showAsList();
                          },
                          child: const Icon(Icons.view_list)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: !isLoading
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: showList
                                  ? registrationsWidgetList()
                                  : registrationsWidgetTable(),
                            ),
                          )
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
                )
              ]),
            ],
          )
          /* Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(child: registrationsWidgetTable()),
              ),
            ),
          ) */
          ),
    );
  }

  Widget registrationsWidgetList() {
    return _registrations.isEmpty
        ? const Center(
            child: Text(
            'Aún no hay registros',
            style: TextStyle(fontSize: 23),
          ))
        : ListView.builder(
            itemCount: _registrations.length,
            itemBuilder: (context, index) {
              final registration = _registrations[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(registration.names),
                  subtitle: Text(registration.surnames),
                  trailing: MaterialButton(
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
                            await _registrationsService.delete(registration.id);
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
                  ),
                ),
              );
            },
          );
  }

  Widget registrationsWidgetTable() {
    print('😁😁😁');
    return _registrations.isEmpty
        ? const Center(
            child: Text(
            'Aún no hay registros',
            style: TextStyle(fontSize: 23),
          ))
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Añadir scroll horizontal
            child: SizedBox(
              child: DataTable(
                columnSpacing: 1,
                border: TableBorder.all(color: Colors.black87),
                columns: const [
                  DataColumn(
                    label: Text('Nombres'),
                  ),
                  DataColumn(
                      label: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text('Apellidos'),
                  )),
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
                rows: _registrations.map((registration) {
                  return DataRow(cells: [
                    DataCell(SizedBox(
                        child: Center(child: Text(registration.names)))),
                    DataCell(Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(
                          width: 200, child: Text(registration.surnames)),
                    )),
                    DataCell(Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child:
                          SizedBox(width: 200, child: Text(registration.curp)),
                    )),
                    DataCell(Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(
                          width: 200, child: Text(registration.career.name)),
                    )),
                    DataCell(Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(
                          width: 200, child: Text(registration.grade.name)),
                    )),
                    DataCell(Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(
                          width: 200, child: Text(registration.group.name)),
                    )),
                    DataCell(Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(
                          width: 200, child: Text(registration.turn.name)),
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
                                  '¿Estás seguro de que deseas eliminar este registro?',
                            ).show(context);

                            if (deleteConfirmed ?? false) {
                              showLoading(true);
                              Map<String, dynamic> result =
                                  await _registrationsService
                                      .delete(registration.id);
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
                  _loadRegistrations();
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadRegistrations() async {
    try {
      showLoading(true);
      List<RegistrationModel> registrations =
          await _registrationsService.getRegistrations();
      setState(() {
        _registrations = registrations;
      });
      print('🎶🎶🎶🎶👍');
      print(_registrations);
      showLoading(false);
    } catch (e) {
      showLoading(false);

      print('Error fetching registrations: $e');
      // Maneja el error apropiadamente
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return NotificationDialogWidget(
            message: 'Hubo un error al cargar los registrations.',
            onConfirm: () {
              Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
            },
          );
        },
      );
    }
  }
}
