import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/network/dio_client.dart';
import 'repositories/movie_repository.dart';
import 'services/movie_service.dart';
import 'viewmodels/movie_viewmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.instance = AppConfig(
    appName: "Movie Explorer Dev",
    baseUrl: "https://www.omdbapi.com",
    flavor: Flavor.dev,
  );

  final dioClient = DioClient();

  final movieService = MovieService(
    dioClient.dio,
  );

  final movieRepository = MovieRepository(
    movieService,
  );
  await Hive.initFlutter();

  await Hive.openBox('favorites');

  runApp(
    ChangeNotifierProvider<MovieViewModel>(
      create: (_) => MovieViewModel(
        movieRepository,
      ),
      child: const MyApp(),
    ),
  );
}