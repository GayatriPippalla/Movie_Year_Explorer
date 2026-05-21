enum Flavor {
  dev,
  staging,
  prod,
}

class AppConfig {

  final String appName;
  final String baseUrl;
  final Flavor flavor;

  static late AppConfig instance;

  AppConfig({
    required this.appName,
    required this.baseUrl,
    required this.flavor,
  });
}