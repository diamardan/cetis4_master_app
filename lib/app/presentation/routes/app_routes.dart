import 'package:datamex_master_app/app/presentation/routes/routes.dart';
import 'package:datamex_master_app/app/presentation/screens/catalogs/views/careers/views/add_careers_view.dart';
import 'package:datamex_master_app/app/presentation/screens/catalogs/views/careers/views/index_careers_view.dart';
import 'package:datamex_master_app/app/presentation/screens/catalogs/views/grades/views/add_grades_view.dart';
import 'package:datamex_master_app/app/presentation/screens/catalogs/views/grades/views/index_grades_view.dart';
import 'package:datamex_master_app/app/presentation/screens/catalogs/views/groups/views/add_groups_view.dart';
import 'package:datamex_master_app/app/presentation/screens/catalogs/views/groups/views/index_groups_view.dart';
import 'package:datamex_master_app/app/presentation/screens/catalogs/views/index_catalogs_view.dart';
import 'package:datamex_master_app/app/presentation/screens/catalogs/views/turns/views/add_turns_view.dart';
import 'package:datamex_master_app/app/presentation/screens/catalogs/views/turns/views/index_turns_view.dart';
import 'package:datamex_master_app/app/presentation/screens/home/views/home_view.dart';
import 'package:datamex_master_app/app/presentation/screens/offline/views/offline_view.dart';
import 'package:datamex_master_app/app/presentation/screens/sign_in/views/sign_in_view.dart';
import 'package:datamex_master_app/app/presentation/screens/splash/views/splash_view.dart';
import 'package:datamex_master_app/app/presentation/screens/students/views/index_students_view.dart';
import 'package:datamex_master_app/app/presentation/screens/students/views/preregistrations/add_preregistration_view.dart';
import 'package:datamex_master_app/app/presentation/screens/students/views/preregistrations/index_preregistrations_view.dart';
import 'package:datamex_master_app/app/presentation/screens/students/views/registrations/index_registrations_view.dart';
import 'package:flutter/material.dart';

import '../screens/students/views/registrations/add_registration_view.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  void goToRoute(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  return {
    Routes.splash: (context) => const SplashView(),
    Routes.signIn: (context) => const SignInView(),
    Routes.home: (context) => const HomeView(),
    Routes.offline: (context) => const OfflineView(),
    Routes.catalogues: (context) => const IndexCatalogsView(),
    Routes.students: (context) => const IndexStudentsView(),
    Routes.career: (context) => const IndexCareers(),
    Routes.addCareer: (context) => const AddCareerView(),
    Routes.grades: (context) => const IndexGrades(),
    Routes.addGrade: (context) => const AddGradeView(),
    Routes.groups: (context) => const IndexGroups(),
    Routes.addGroup: (context) => const AddGroupView(),
    Routes.turns: (context) => const IndexTurns(),
    Routes.addTurn: (context) => const AddTurnView(),
    Routes.registrations: (context) => const IndexRegistrations(),
    Routes.addRegistrations: (context) => const AddRegistrationView(),
    Routes.preregistrations: (context) => const IndexPreregistrations(),
    Routes.addPreregistrations: (context) => const AddPreregistrationView(),
  };
}
