import 'package:datamex_master_app/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../../main.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    final injector = Injector.of(context);
    final connectivityRepository = injector.connectivityRepository;
    final hasInternet = await connectivityRepository.hasInternet;
    print('😍 hasInternet $hasInternet');
    if (hasInternet) {
      final authenticationRepository = injector.authenticationRepository;
      final isSignedIn = await authenticationRepository.isSignedIn;
      if (isSignedIn) {
        final user = await authenticationRepository.getUserData();
        if (mounted) {
          if (user != null) {
            //home
            _goTo(Routes.home);
          } else {
            //sign in
            _goTo(Routes.signIn);
          }
        }
      } else if (mounted) {
        _goTo(Routes.signIn);
      }
    } else {
      _goTo(Routes.offline);
    }
  }

  void _goTo(String routeNamed) {
    Navigator.pushReplacementNamed(context, routeNamed);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            SizedBox(width: 80, height: 80, child: CircularProgressIndicator()),
      ),
    );
  }
}
