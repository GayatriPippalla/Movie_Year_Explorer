import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/movie_details_model.dart';
import '../models/movie_response.dart';

part 'movie_service.g.dart';

@RestApi()
abstract class MovieService {

  factory MovieService(
    Dio dio, {
    String? baseUrl,
  }) = _MovieService;

  // SEARCH MOVIES (OMDb uses `s` for title/year query and supports `page`)
 @GET('/')
Future<MovieResponse> searchMovies(

  @Query('s') String search,

  @Query('page') int page,
);

  // GET FULL MOVIE DETAILS
  @GET('/')
  Future<MovieDetailsModel> getMovieDetails(

    @Query('i') String imdbId,
  );
}