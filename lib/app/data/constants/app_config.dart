class AppConfig {
  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();
  static final AppConfig _instance = AppConfig._internal();

  String appVersion = ''; // Aquí puedes definir otros valores también
}
