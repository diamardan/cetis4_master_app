import 'package:datamex_master_app/app/data/constants/app_version.dart';
import 'package:datamex_master_app/app/domain/enums.dart';
import 'package:datamex_master_app/app/presentation/global/painters/card_painter.dart';
import 'package:datamex_master_app/app/presentation/global/painters/wave_clipper.dart';
import 'package:datamex_master_app/app/presentation/routes/routes.dart';
import 'package:datamex_master_app/main.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = '', _password = '';
  bool _fetching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              padding: const EdgeInsets.only(bottom: 250),
              color: Colors.blue.withOpacity(.4),
              height: 220,
              alignment: Alignment.center,
            ),
          ),
          ClipPath(
            clipper: WaveClipper(waveDeep: 0, waveDeep2: 100),
            child: Container(
              padding: const EdgeInsets.only(bottom: 50),
              color: Colors.blue.withOpacity(.7),
              height: 180,
              alignment: Alignment.center,
            ),
          ),
          SafeArea(
            child: Center(
              child: SizedBox(
                height: 350,
                width: 600,
                child: Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: CustomPaint(
                      painter: CardPainter(),
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Form(
                          child: AbsorbPointer(
                            absorbing: _fetching,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (text) {
                                    setState(() {
                                      _username = text.trim().toLowerCase();
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Usuario'),
                                  validator: (text) {
                                    text = text?.trim().toLowerCase() ?? '';
                                    if (text.isEmpty) {
                                      return 'Usuario inválido';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (text) {
                                    setState(() {
                                      _password = text.replaceAll(' ', '');
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Contraseña'),
                                  validator: (text) {
                                    text = text?.replaceAll(' ', '') ?? '';
                                    if (text.length < 6) {
                                      return 'Contraseña inválida';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Builder(builder: (context) {
                                  if (_fetching) {
                                    return const CircularProgressIndicator();
                                  }
                                  return MaterialButton(
                                    onPressed: () {
                                      final isValid =
                                          Form.of(context).validate();
                                      if (isValid) {
                                        _submit(context);
                                      }
                                    },
                                    color: Colors.blue,
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    child: const Text('Iniciar sesión'),
                                  );
                                }),
                                Text(Version.current)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    setState(() {
      _fetching = true;
    });
    final result = await Injector.of(context)
        .authenticationRepository
        .signIn(_username, _password);

    if (!mounted) {
      return;
    }
    result.when((failure) {
      setState(() {
        _fetching = false;
      });
      final message = {
        SignInFailure.notFound: 'Not Found',
        SignInFailure.unauthorized: 'Invalid password',
        SignInFailure.unknown: 'Error',
      }[failure];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message!),
        ),
      );
    }, (user) {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }
}
