import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class AppVersion {
  static String version = '';

  static Future<void> initialize() async {
    final pubspecContent = await rootBundle.loadString('pubspec.yaml');
    final pubspec = json.decode(pubspecContent);
    version = pubspec['version'];
  }
}

class Version {
  static String current = AppVersion.version;
}
