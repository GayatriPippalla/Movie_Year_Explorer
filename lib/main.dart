import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/app_config.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.instance = AppConfig(
    appName: "Movie Explorer",
    baseUrl: "https://www.omdbapi.com",
    flavor: Flavor.prod,
  );

  await Hive.initFlutter();
  await Hive.openBox('favorites');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}


