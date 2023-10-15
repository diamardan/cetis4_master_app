import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_autocomplete_widget.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_form_button_widget.dart';
import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_textformfield_widget.dart';
import 'package:flutter/material.dart';

class IndexDigitalCredential extends StatefulWidget {
  const IndexDigitalCredential({Key? key}) : super(key: key);

  @override
  State<IndexDigitalCredential> createState() => _IndexDigitalCredentialState();
}

class _IndexDigitalCredentialState extends State<IndexDigitalCredential> {
  TextEditingController curpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Buscar por C.U.R.P.',
              ),
              Tab(
                text: 'Buscar por apellidos',
              )
            ],
          ),
        ),
        body: _searchStudentForm(),
      ),
    );
  }

  Widget _searchStudentForm() {
    return TabBarView(children: [_searchByCurp(), _searchBySurnames()]);
  }

  Widget _searchByCurp() {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
                child: Column(
              children: [
                DatamexTextFormField(
                  labelText: 'C.U.R.P.',
                  controller: curpController,
                  boxHeight: 12,
                  minLength: 18,
                  maxLength: 18,
                  acceptDiacritics: false,
                  validate: true,
                ),
                DatamexFormButton(
                    color: Colors.blue, onPress: () {}, label: 'Buscar')
              ],
            )),
          ),
        ));
  }

  Widget _searchBySurnames() {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
                child: Column(
              children: [
                DatamexAutocompleteWidget(
                  onSuggestionSelected: (p0) {},
                ),
                DatamexFormButton(
                    color: Colors.blue, onPress: () {}, label: 'Buscar')
              ],
            )),
          ),
        ));
  }
}
