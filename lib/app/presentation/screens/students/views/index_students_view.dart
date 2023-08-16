import 'package:datamex_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_card_menu_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/menu_button_widget.dart';
import 'package:datamex_master_app/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class IndexStudentsView extends StatelessWidget {
  const IndexStudentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Alumnos'),
      body: DatamexCardMenu(children: [
        menuButton(context, 'assets/catalogos.png', 'Registros',
            Routes.registrations, () {}),
        menuButton(context, 'assets/catalogos.png', 'Pre registros',
            Routes.preregistrations, () {}),
      ]),
    );
  }
}
