// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:movie_year_explorer/app.dart';
import 'package:movie_year_explorer/core/config/app_config.dart';
import 'package:movie_year_explorer/core/network/dio_client.dart';
import 'package:movie_year_explorer/repositories/movie_repository.dart';
import 'package:movie_year_explorer/services/movie_service.dart';
import 'package:movie_year_explorer/viewmodels/movie_viewmodel.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Ensure config is initialized for tests.
    AppConfig.instance = AppConfig(
      appName: 'Test',
      baseUrl: 'https://example.com',
      flavor: Flavor.dev,
    );

    final dio = DioClient().dio;
    final service = MovieService(dio);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => MovieViewModel(MovieRepository(service)),
          ),
        ],
        child: const MyApp(),
      ),
    );

    // Basic sanity check: Home screen title exists.
    expect(find.text('Movie Year Explorer'), findsOneWidget);
  });
}


