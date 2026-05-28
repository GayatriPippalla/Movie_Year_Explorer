import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:movie_year_explorer/models/movie_details_model.dart';
import 'package:movie_year_explorer/models/movie_response.dart';

part 'movie_service.g.dart';

@RestApi()
abstract class MovieService {
  factory MovieService(
    Dio dio, {
    String? baseUrl,
  }) = _MovieService;

  @GET('/')
  Future<MovieResponse> searchMovies(
    @Query('s') String search,
    @Query('page') int page,
  );

  @GET('/')
  Future<MovieDetailsModel> getMovieDetails(
    @Query('i') String imdbId,
  );
}