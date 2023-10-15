import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const splash = '/splash';
  static const signIn = '/sign-in';
  static const home = '/home';
  static const offline = '/offline';
  static const catalogues = '/catalogues';
  static const students = '/students';
  static const career = '/career';
  static const addCareer = '/add-career';
  static const grades = '/grades';
  static const addGrade = '/add-grade';
  static const groups = '/groups';
  static const addGroup = '/add-group';
  static const turns = '/turns';
  static const addTurn = '/add-turn';
  static const preregistrations = '/preregistrations';
  static const addPreregistrations = '/add-preregistration';
  static const registrations = '/registrations';
  static const addRegistrations = '/add-registration';
  static const addPreregistrationsPublic = '/add-preregistration-public';
  static const digitalCredential = '/digital-credential';
  static const notifications = '/notifications';

  static void goToRoute(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }
}
