import 'package:datamex_master_app/app/presentation/global/painters/my_custom_painter.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:datamex_master_app/app/presentation/global/widgets/menu_button_widget.dart';
import 'package:datamex_master_app/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedSchool = ''; // Escuela predeterminada
  void _selectSchool(String school) {
    setState(() {
      selectedSchool = school;
    });
    Navigator.pop(context); // Cerrar Drawer después de la selección
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text('Registro de Escuelas'),
      ), */
      appBar: const DatamexAppBarWidget(
        title: 'Registro de alumnos',
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Seleccione una Escuela',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Escuela 1'),
              onTap: () => _selectSchool('Escuela 1'),
            ),
            ListTile(
              title: const Text('Escuela 2'),
              onTap: () => _selectSchool('Escuela 2'),
            ),
            // Agregar más list tiles para otras escuelas si es necesario
          ],
        ),
      ),
      body: SafeArea(
        child: CustomPaint(
          painter: MiCustomPainter(),
          child: SizedBox(
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    runAlignment: WrapAlignment.start,
                    children: [
                      menuButton(
                        context,
                        'assets/catalogos.png',
                        'Catálogos',
                        Routes.catalogues,
                        () {},
                      ),
                      menuButton(
                        context,
                        'assets/alumno.png',
                        'Alumnos',
                        Routes.students,
                        () {},
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
