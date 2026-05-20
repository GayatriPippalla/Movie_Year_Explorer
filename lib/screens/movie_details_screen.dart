import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie_details_model.dart';
import '../viewmodels/movie_viewmodel.dart';

class MovieDetailsScreen extends StatefulWidget {

  final String imdbId;

  const MovieDetailsScreen({
    super.key,
    required this.imdbId,
  });

  @override
  State<MovieDetailsScreen> createState() =>
      _MovieDetailsScreenState();
}

class _MovieDetailsScreenState
    extends State<MovieDetailsScreen> {

  MovieDetailsModel? movie;

  bool isLoading = true;

  String? error;

  @override
  void initState() {

    super.initState();

    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {

    try {

      final repository =
      context
          .read<MovieViewModel>()
          .repository;

      movie =
      await repository.getMovieDetails(
        widget.imdbId,
      );

    } catch (e) {

      error = e.toString();

    } finally {

      setState(() {

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // LOADING
    if (isLoading) {

      return const Scaffold(

        body: Center(
          child:
          CircularProgressIndicator(),
        ),
      );
    }

    // ERROR
    if (error != null) {

      return Scaffold(

        appBar: AppBar(),

        body: Center(
          child: Text(error!),
        ),
      );
    }

    final m = movie!;

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Movie Details',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(


        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // POSTER
            Image.network(

              m.poster,

              width: double.infinity,

              height: 450,

              fit: BoxFit.cover,

              errorBuilder:
                  (_, __, ___) {

                return Container(

                  height: 450,

                  color: Colors.grey,

                  child: const Center(

                    child: Icon(
                      Icons.movie,
                      size: 100,
                    ),
                  ),
                );
              },
            ),

            Padding(

              padding:
              const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(

                    m.title,

                    style:
                    const TextStyle(

                      fontSize: 30,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Year: ${m.year}',
                    style:
                    const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Genre: ${m.genre}',
                    style:
                    const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Director: ${m.director}',
                    style:
                    const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Actors: ${m.actors}',
                    style:
                    const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'IMDb Rating: ${m.imdbRating}',
                    style:
                    const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Runtime: ${m.runtime}',
                    style:
                    const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 20),

                  const Text(

                    'Plot',

                    style: TextStyle(

                      fontSize: 24,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(

                    m.plot,

                    style:
                    const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}