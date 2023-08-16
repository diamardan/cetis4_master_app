import 'package:datamex_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_card_menu_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/menu_button_widget.dart';
import 'package:datamex_master_app/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class IndexCatalogsView extends StatelessWidget {
  const IndexCatalogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Catálogos'),
      body: DatamexCardMenu(children: [
        menuButton(
            context, 'assets/catalogos.png', 'Carreras', Routes.career, () {}),
        menuButton(
            context, 'assets/catalogos.png', 'Grados', Routes.grades, () {}),
        menuButton(
            context, 'assets/catalogos.png', 'Grupos', Routes.groups, () {}),
        menuButton(
            context, 'assets/catalogos.png', 'Turnos', Routes.turns, () {}),
      ]),
    );
  }
}
