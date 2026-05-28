import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movie_year_explorer/core/network/dio_client.dart';
import 'package:movie_year_explorer/repositories/movie_repository.dart';
import 'package:movie_year_explorer/services/movie_service.dart';
import 'package:movie_year_explorer/viewmodels/movie_viewmodel.dart';

final movieViewModelProvider =
    ChangeNotifierProvider<MovieViewModel>((ref) {



  final dioClient = DioClient();

  final service =
      MovieService(dioClient.dio);

  final repository =
      MovieRepository(service);

  return MovieViewModel(repository);
});