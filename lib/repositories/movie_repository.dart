import 'package:movie_year_explorer/models/movie_details_model.dart';
import 'package:movie_year_explorer/models/movie_response.dart';
import 'package:movie_year_explorer/services/movie_service.dart';

class MovieRepository {

  final MovieService service;

  MovieRepository(this.service);

  // SEARCH MOVIES BY YEAR
  Future<MovieResponse> searchMoviesByYear(
    String year,
    int page,
  ) {
    return service.searchMovies(
      year,
      page,
    );
  }

  // Backward-compatible alias
  Future<MovieResponse> searchMovies(
    String year,
    int page,
  ) {
    return searchMoviesByYear(year, page);
  }
  // GET DETAILS
  Future<MovieDetailsModel> getMovieDetails(
    String imdbId,
  ) {
    return service.getMovieDetails(
      imdbId,
    );
  }
}
