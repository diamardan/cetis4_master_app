import 'package:cetis4_master_app/app/data/services/remote/preregistrations.service.dart';
import 'package:cetis4_master_app/app/domain/models/preregistration.dart';
import 'package:cetis4_master_app/app/presentation/global/painters/my_custom_painter.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_form_button_widget.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_textformfield_widget.dart';
import 'package:flutter/material.dart';

class PublicAddPreregistration extends StatefulWidget {
  const PublicAddPreregistration({Key? key}) : super(key: key);

  @override
  State<PublicAddPreregistration> createState() =>
      _PublicAddPreregistrationState();
}

class _PublicAddPreregistrationState extends State<PublicAddPreregistration> {
  bool hasData = false;
  double boxHeight = 1;
  TextEditingController curpController = TextEditingController();
  TextEditingController namesController = TextEditingController();
  TextEditingController surnamesController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cellphoneController = TextEditingController();

  PreregistrationsService preregistrationsService = PreregistrationsService();
  List<PreregistrationModel> preregistration = [];
  GlobalKey formKey = GlobalKey();

  Future<void> searchAndPopulate() async {
    try {
      preregistration =
          await preregistrationsService.searchByCurp(curpController.text);

      print(preregistration[0].names);
      setState(() {
        hasData = preregistration.isEmpty ? false : true;
      });
    } catch (e) {
      showDialogMessage(e.toString());
      print(e);
    }
  }

  void showDialogMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message), // Muestra el mensaje de error recibido
        duration: const Duration(seconds: 2), // Duración del mensaje
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Preregistro escolar'),
      body: SafeArea(
          child: CustomPaint(
        painter: MiCustomPainter(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (!hasData)
                        Column(
                          children: [
                            DatamexTextFormField(
                              labelText: 'C.U.R.P',
                              boxHeight: boxHeight,
                              controller: curpController,
                              maxLength: 18,
                              minLength: 18,
                              validate: true,
                              acceptDiacritics: false,
                              keyboardType: TextInputType.name,
                            ),
                            DatamexFormButton(
                                label: 'Buscar',
                                color: Colors.green.shade700,
                                onPress: () async {
                                  searchAndPopulate();
                                })
                          ],
                        )
                      else
                        Column(
                          children: [
                            DatamexTextFormField(
                              boxHeight: boxHeight,
                              labelText: 'Nombres',
                              validate: true,
                              controller: namesController,
                              acceptDiacritics: false,
                              keyboardType: TextInputType.name,
                            ),
                            DatamexTextFormField(
                              boxHeight: boxHeight,
                              labelText: 'Apellidos',
                              validate: true,
                              controller: surnamesController,
                              acceptDiacritics: false,
                              keyboardType: TextInputType.name,
                            ),
                            DatamexTextFormField(
                                boxHeight: boxHeight,
                                labelText: 'C.U.R.P.',
                                validate: true,
                                controller: curpController,
                                acceptDiacritics: false,
                                keyboardType: TextInputType.name,
                                enabled: false)
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
