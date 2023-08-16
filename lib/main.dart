import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:datamex_master_app/app/data/constants/constants.dart';
import 'package:datamex_master_app/app/data/http/http.dart';
import 'package:datamex_master_app/app/data/services/remote/authentication.service.dart';
import 'package:datamex_master_app/app/data/services/remote/internet_checker.dart';
import 'package:datamex_master_app/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Cargar la versión desde el pubspec.yaml
  //await AppVersion.initialize(); // Inicializa la constante de versión
  runApp(Injector(
    connectivityRepository: ConnectivityRepositoryImpl(
      Connectivity(),
      InternetChecker(),
    ),
    authenticationRepository: AuthenticationRepositoryImpl(
      const FlutterSecureStorage(),
      AuthenticationService(
        Http(
          client: http.Client(),
          baseUrl: AppConstants.baseUrl,
        ),
      ),
    ),
    child: const MyApp(),
  ));
}

class Injector extends InheritedWidget {
  const Injector(
      {super.key,
      required super.child,
      required this.connectivityRepository,
      required this.authenticationRepository});

  final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authenticationRepository;
  @override
  bool updateShouldNotify(_) => false;

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }
}

/* class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          /* appBar: AppBar(
            title: const Text('Material App Bar'),
            backgroundColor: AppColors.primaryColor,
          ), */
          body: CustomPaint(
        painter: BackgroundPainter(),
        child: LoginPage(),
      )),
    );
  }
}
 */