import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_dropdown_widget.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_quill_editor_widget.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_textformfield_widget.dart';
import 'package:cetis4_master_app/app/presentation/utils/common_response.dart';
import 'package:flutter/material.dart';

import '../../global/widgets/datamex_autocomplete_widget.dart';

class CreateNotificationForm extends StatefulWidget {
  const CreateNotificationForm({Key? key}) : super(key: key);

  @override
  State<CreateNotificationForm> createState() => _CreateNotificationFormState();
}

class _CreateNotificationFormState extends State<CreateNotificationForm> {
  GlobalKey formKey = GlobalKey();
  TextEditingController asuntoController = TextEditingController();
  bool showAlumnoSearch = false; // Estado para mostrar el TextFormField
  // Elementos para el dropdown
  final List<CommonResponse> dropdownItems = [
    IndividualResponse(),
    ConFiltrosResponse(),
    MasivoResponse(),
  ];

  // Valor inicial seleccionado para el dropdown
  CommonResponse? initialValue;

  @override
  void initState() {
    super.initState();
    initialValue = dropdownItems.first;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              DatamexDropDownMenuWidget(
                  items: dropdownItems,
                  labelText: 'Para',
                  onChanged: datamexDropDownOnChanged,
                  initialValue: initialValue!.name),
              if (showAlumnoSearch)
                DatamexAutocompleteWidget(
                  onSuggestionSelected: (suggestion) {
                    // Aquí puedes manejar la selección del alumno
                    print('Alumno seleccionado: $suggestion');
                  },
                ),
              DatamexTextFormField(
                  labelText: 'Asunto',
                  boxHeight: 12,
                  controller: asuntoController),
              const Divider(thickness: 12),
              const DatamexQuillEditor(),
            ]),
          ),
        ),
      ),
    );
  }

  datamexDropDownOnChanged(CommonResponse selectedValue) {
    /* print(selectedValue.name); */
    setState(() {
      // Mostrar el TextFormField solo si se selecciona 'INDIVIDUAL'
      showAlumnoSearch = selectedValue.name == 'INDIVIDUAL';
    });
  }
}
