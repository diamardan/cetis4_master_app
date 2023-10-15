import 'package:cetis4_master_app/app/presentation/routes/app_routes.dart';
import 'package:cetis4_master_app/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash,
          routes: appRoutes),
    );
  }
}
