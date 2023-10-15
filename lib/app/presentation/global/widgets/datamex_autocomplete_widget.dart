import 'package:cetis4_master_app/app/data/services/remote/preregistrations.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DatamexAutocompleteWidget extends StatefulWidget {
  const DatamexAutocompleteWidget(
      {Key? key, required this.onSuggestionSelected})
      : super(key: key);
  final Function(Map<String, dynamic>) onSuggestionSelected;

  @override
  _DatamexAutocompleteWidgetState createState() =>
      _DatamexAutocompleteWidgetState();
}

class _DatamexAutocompleteWidgetState extends State<DatamexAutocompleteWidget> {
  final TextEditingController _searchController = TextEditingController();
  final PreregistrationsService _preregistrationsService =
      PreregistrationsService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(() {
      final text = _searchController.text.toUpperCase();
      if (_searchController.text != text) {
        _searchController.value = _searchController.value.copyWith(
          text: text,
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TypeAheadField(
            noItemsFoundBuilder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'No se encontró el preregistro',
                  style: TextStyle(color: Colors.red.shade600, fontSize: 16),
                ),
              );
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller: _searchController,
              decoration:
                  const InputDecoration(labelText: 'Buscar por apellidos'),
            ),
            suggestionsCallback: (query) async {
              return await _preregistrationsService.searchByApellidos(query);
            },
            itemBuilder: (context, suggestion) {
              final String names = suggestion['names'];
              final String surnames = suggestion['surnames'];
              final String curp = suggestion['curp'];

              /* final String email = suggestion['email'];
              final String cellphone = suggestion['cellphone'] as String;
              final String registrationNumber =
                  suggestion['registration_number'];
              final String idbio = suggestion['idbio'];
              final String career = suggestion['career'];
              final String grade = suggestion['grade'];
              final String group = suggestion['group'];
              final String turn = suggestion['turn'];
              final String studentSignaturePath =
                  suggestion['student_signature_path'];
              final String studentPhotoPath = suggestion['student_photo_path']; */
              print(suggestion);

              return ListTile(
                title: Text('$names $surnames '),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(curp),
                  ],
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              widget.onSuggestionSelected(suggestion);
            },
            debounceDuration: const Duration(milliseconds: 750),
          ),
        ],
      ),
    );
  }
}
