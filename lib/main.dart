import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/network/dio_client.dart';
import 'repositories/movie_repository.dart';
import 'services/movie_service.dart';
import 'viewmodels/movie_viewmodel.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

