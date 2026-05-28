import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/config/app_config.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.instance = AppConfig(
    appName: "Movie Explorer Dev",
    baseUrl: "https://www.omdbapi.com",
    flavor: Flavor.dev,
  );

  await Hive.initFlutter();

  await Hive.openBox('favorites');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}