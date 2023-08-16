import 'package:datamex_master_app/app/data/services/remote/grades.service.dart';
import 'package:datamex_master_app/app/presentation/global/painters/my_custom_painter.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:datamex_master_app/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../../global/widgets/datamex_textformfield_widget.dart';

class AddGradeView extends StatefulWidget {
  const AddGradeView({Key? key}) : super(key: key);

  @override
  State<AddGradeView> createState() => _AddGradeViewState();
}

class _AddGradeViewState extends State<AddGradeView> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final TextEditingController nameController = TextEditingController();
    GradesService gradeService = GradesService();

    return Scaffold(
      appBar: const DatamexAppBarWidget(
        title: 'Agregar grado',
      ),
      body: SafeArea(
        child: CustomPaint(
          painter: MiCustomPainter(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    DatamexTextFormField(
                        labelText: 'Nombre del grado',
                        boxHeight: 12,
                        controller: nameController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final name = nameController.text;

                              // Almacenar el contexto antes de entrar en el contexto asíncrono
                              final currentContext = context;
                              // Enviar los datos al backend
                              await gradeService.addGrade(name);

                              // Cerrar el modal después de guardar
                              Navigator.pushReplacementNamed(
                                  context, Routes.grades);
                            }
                          },
                          color: Colors.green.shade800,
                          child: const SizedBox(
                              height: 35,
                              child: Center(
                                child: Text(
                                  'Guardar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Colors.red.shade800,
                          child: const SizedBox(
                              height: 35,
                              child: Center(
                                child: Text(
                                  'Cancelar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
