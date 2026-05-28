import 'dart:async';

import 'package:flutter/material.dart';

import 'package:movie_year_explorer/models/movie_model.dart';
import 'package:movie_year_explorer/repositories/movie_repository.dart';
import 'package:movie_year_explorer/services/local_storage_service.dart';

/// ViewModel responsible for:
/// - Movie search
/// - Pagination
/// - Favorites
/// - UI state management
class MovieViewModel extends ChangeNotifier {

  final MovieRepository repository;
  final LocalStorageService localStorageService =
    LocalStorageService();

  MovieViewModel(this.repository) {

  favoriteMovieIds =
      localStorageService.getFavorites();
}

  // MOVIES
  List<MovieModel> movies = [];

  // FAVORITES
  List<String> favoriteMovieIds = [];

  // LOADING STATES
  bool isLoading = false;

  bool isPaginationLoading = false;

  // ERROR
  String? error;

  // PAGINATION
  int page = 1;

  bool hasMore = true;

  // CURRENT SEARCH YEAR
  String currentYear = '';

  // DEBOUNCE
  Timer? debounce;

  // SCROLL CONTROLLER
  final ScrollController scrollController =
      ScrollController();

  // SEARCH MOVIES BY YEAR
  Future<void> searchMovies(
      String year,
      ) async {

    // VALIDATE YEAR
    if (year.length != 4) {

      movies.clear();

      notifyListeners();

      return;
    }

    try {

      isLoading = true;

      error = null;

      page = 1;

      hasMore = true;

      currentYear = year;

      movies.clear();

      notifyListeners();

      final response =
      await repository.searchMoviesByYear(
        year,
        page,
      );

      // EXACT YEAR FILTER
      movies =

          (response.movies ?? [])

              .where(

                (movie) =>
            movie.year == year,
      )

              .toList();

    } catch (e) {

      error = e.toString();

    } finally {

      isLoading = false;

      notifyListeners();
    }
  }

  // PAGINATION
  Future<void> loadMore() async {

    if (!hasMore ||
        currentYear.isEmpty) {

      return;
    }

    try {

      isPaginationLoading = true;

      notifyListeners();

      page++;

      final response =
      await repository.searchMoviesByYear(
        currentYear,
        page,
      );

      final newMovies =

      (response.movies ?? [])

          .where(

            (movie) =>
        movie.year == currentYear,
      )

          .toList();

      // NO MORE DATA
      if (newMovies.isEmpty) {

        hasMore = false;

      } else {

        movies.addAll(newMovies);
      }

    } catch (e) {

      error = e.toString();

    } finally {

      isPaginationLoading = false;

      notifyListeners();
    }
  }

  // SEARCH DEBOUNCE
  void onSearchChanged(String value) {

    if (debounce?.isActive ?? false) {

      debounce!.cancel();
    }

    debounce = Timer(

      const Duration(milliseconds: 500),

          () {

        searchMovies(value);
      },
    );
  }

  // TOGGLE FAVORITE
  void toggleFavorite(String imdbId) {

    if (favoriteMovieIds.contains(imdbId)) {

      favoriteMovieIds.remove(imdbId);

    } else {

      favoriteMovieIds.add(imdbId);
    }
    localStorageService.saveFavorites(
    favoriteMovieIds,
  );

    notifyListeners();
  }

  // CHECK FAVORITE
  bool isFavorite(String imdbId) {

    return favoriteMovieIds.contains(imdbId);
  }

  // REFRESH
  Future<void> refreshMovies() async {

    page = 1;

    hasMore = true;

    movies.clear();

    await searchMovies(currentYear);
  }

  // DISPOSE
  @override
  void dispose() {

    debounce?.cancel();

    scrollController.dispose();

    super.dispose();
  }
}