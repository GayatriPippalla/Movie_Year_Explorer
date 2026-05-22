import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/config/app_config.dart';
import 'core/network/dio_client.dart';
import 'repositories/movie_repository.dart';
import 'services/movie_service.dart';
import 'viewmodels/movie_viewmodel.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.instance = AppConfig(
    appName: "Movie Explorer",
    baseUrl: "https://www.omdbapi.com",
    flavor: Flavor.prod,
  );

  final dio = DioClient().dio;
  final service = MovieService(dio);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieViewModel(
            MovieRepository(service),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

