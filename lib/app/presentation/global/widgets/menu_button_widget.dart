import 'package:flutter/material.dart';

Widget menuButton(
  BuildContext context,
  String imagePath,
  String buttonLabel,
  String route,
  Function onPressed,
) {
  return Card(
    child: SizedBox(
      height: 200,
      width: 200,
      child: MaterialButton(
        onPressed: () {
          goTo(context, route);
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image(image: AssetImage(imagePath), height: 80),
          const SizedBox(
            height: 20,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              buttonLabel,
              style: const TextStyle(fontSize: 22),
            ),
          ),
        ]),
      ),
    ),
  );
}

goTo(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}
