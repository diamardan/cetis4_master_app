import 'package:datamex_master_app/app/domain/models/registration.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_textformfield_widget.dart';
import 'package:flutter/material.dart';

class DetailsRegistrationView extends StatefulWidget {
  const DetailsRegistrationView({Key? key, required this.registration})
      : super(key: key);
  final RegistrationModel registration;

  @override
  State<DetailsRegistrationView> createState() =>
      _DetailsRegistrationViewState();
}

class _DetailsRegistrationViewState extends State<DetailsRegistrationView> {
  final TextEditingController _namesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    populateForm();
  }

  void populateForm() async {
    _namesController.text = widget.registration.names;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double boxHeight = 4;
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Detalles de registro'),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DatamexTextFormField(
                      labelText: 'Nombres',
                      boxHeight: boxHeight,
                      controller: _namesController),
                  Text('Nombres: ${widget.registration.names}'),
                  Text('Apellidos: ${widget.registration.surnames}'),
                  // Mostrar otros detalles aquí...
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
