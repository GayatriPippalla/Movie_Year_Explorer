import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/network/dio_client.dart';
import 'repositories/movie_repository.dart';
import 'screens/home_screen.dart';
import 'services/movie_service.dart';
import 'viewmodels/movie_viewmodel.dart';

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


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        brightness: Brightness.dark,

        scaffoldBackgroundColor:
        const Color(0xFF0F0F0F),

        primaryColor: Colors.red,

        appBarTheme: const AppBarTheme(

          backgroundColor:
          Color(0xFF1A1A1A),

          elevation: 0,

          centerTitle: true,
        ),

        inputDecorationTheme:
        InputDecorationTheme(

          filled: true,

          fillColor:
          const Color(0xFF1E1E1E),

          border: OutlineInputBorder(

            borderRadius:
            BorderRadius.circular(14),

            borderSide: BorderSide.none,
          ),

          enabledBorder:
          OutlineInputBorder(

            borderRadius:
            BorderRadius.circular(14),

            borderSide: BorderSide.none,
          ),

          focusedBorder:
          OutlineInputBorder(

            borderRadius:
            BorderRadius.circular(14),

            borderSide: const BorderSide(

              color: Colors.red,

              width: 2,
            ),
          ),
        ),
      ),

      home: const HomeScreen(),
    );
  }
}
