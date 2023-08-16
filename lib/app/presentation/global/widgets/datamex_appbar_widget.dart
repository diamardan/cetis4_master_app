import 'package:datamex_master_app/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class DatamexAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const DatamexAppBarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'signOut') {
              Injector.of(context).authenticationRepository.signOut();
              Navigator.pushReplacementNamed(context, Routes.signIn);
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'signOut',
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Cerrar sesión'),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
