import 'package:cetis4_master_app/app/data/services/remote/groups.service.dart';
import 'package:cetis4_master_app/app/domain/models/groups.dart';
import 'package:cetis4_master_app/app/presentation/global/painters/my_custom_painter.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_delete_confirmation.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_index_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../global/dialogs/datamex_notification_dialog_widget.dart';
import '../../../../../routes/routes.dart';

class IndexGroups extends StatefulWidget {
  const IndexGroups({Key? key}) : super(key: key);

  @override
  State<IndexGroups> createState() => _IndexGroupsState();
}

class _IndexGroupsState extends State<IndexGroups> {
  List<GroupsModel> _groups = [];
  final GroupsService _groupsProvider = GroupsService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Grupos'),
      body: CustomPaint(
        painter: MiCustomPainter(),
        child: DatamexIndexMenu(children: [
          ElevatedButton(
              onPressed: () {
                Routes.goToRoute(context, Routes.addGroup);
              },
              child: const Text('Agregar')),
          const SizedBox(
            height: 10,
          ),
          Column(children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(child: gruposWidgetTable()),
                ),
              ),
            ),
          ])
        ]),
        /* Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(child: gruposWidgetTable()),
              ),
            ),
          ) */
      ),
    );
  }

  Widget gruposWidgetTable() {
    print('😁😁😁');
    return _groups.isEmpty
        ? const Center(
            child: /* CircularProgressIndicator() */
                Text(
            'Aún no hay grupos',
            style: TextStyle(fontSize: 23),
          ))
        : SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            child: SingleChildScrollView(
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
                rows: _groups.map((group) {
                  return DataRow(cells: [
                    /* DataCell(SizedBox(
                      child: Center(child: Text(group.id.toString())))), */
                    DataCell(Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(width: 200, child: Text(group.name)),
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
                                  await _groupsProvider.delete(group.id);
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
                  _loadGroups();
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadGroups() async {
    try {
      List<GroupsModel> groups = await _groupsProvider.getGroups();
      setState(() {
        _groups = groups;
      });
      print('🎶🎶🎶🎶👍');
      print(_groups);
    } catch (e) {
      print('Error fetching groups: $e');
      // Maneja el error apropiadamente
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return NotificationDialogWidget(
            message: 'Hubo un error al cargar los groups.',
            onConfirm: () {
              Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
            },
          );
        },
      );
    }
  }
}
