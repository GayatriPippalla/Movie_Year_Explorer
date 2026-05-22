import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/movie_viewmodel.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MovieViewModel>();

    final screenWidth =
    MediaQuery.of(context).size.width;

final isMobile = screenWidth < 600;

final isTablet =
    screenWidth >= 600 &&
    screenWidth < 1000;

final isDesktop =
    screenWidth >= 1000;

final posterWidth =
    isDesktop
        ? 150.0
        : isTablet
            ? 120.0
            : 90.0;

final posterHeight =
    isDesktop
        ? 220.0
        : isTablet
            ? 170.0
            : 130.0;

final titleFontSize =
    isDesktop
        ? 28.0
        : isTablet
            ? 24.0
            : 20.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Year Explorer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: EdgeInsets.all(
              screenWidth * 0.02,
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              maxLength: 4,
              onChanged: (value) {
                vm.onSearchChanged(value);
              },
              decoration: InputDecoration(
                counterText: '',
                hintText: 'Enter release year (2025)',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(
                  Icons.calendar_today,
                  color: Colors.red,
                ),
              ),
            ),
          ),

          Expanded(
            child: Builder(
              builder: (_) {
                // LOADING
                if (vm.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // ERROR
                if (vm.error != null) {
                  return Center(
                    child: Text(vm.error!),
                  );
                }

                // EMPTY
                if (vm.movies.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          'Search movies by year',
                          style: TextStyle(
                            fontSize:
                                screenWidth > 600
                                    ? 32
                                    : 24,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Try 2020, 2021, 2025',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // SUCCESS
                return NotificationListener<
                    ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels >=
                        scrollInfo.metrics
                                .maxScrollExtent -
                            200) {
                      vm.loadMore();
                    }

                    return true;
                  },
                  child: ListView.builder(
                    itemCount:
                        vm.movies.length + 1,
                    itemBuilder: (_, index) {
                      // PAGINATION LOADER
                      if (index ==
                          vm.movies.length) {
                        return vm
                                .isPaginationLoading
                            ? const Padding(
                                padding:
                                    EdgeInsets.all(
                                        20),
                                child: Center(
                                  child:
                                      CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox();
                      }

                      final movie =
                          vm.movies[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  MovieDetailsScreen(
                                imdbId:
                                    movie.imdbId,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color:
                              const Color(0xFF1A1A1A),
                          elevation: 5,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    16),
                          ),
                          margin:
                              EdgeInsets.symmetric(
                            horizontal:
                                screenWidth * 0.02,
                            vertical: 8,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(
                                    10),
                            child: Row(
                              children: [
                                // POSTER
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              12),
                                  child:
                                      Image.network(
                                    movie.poster,
                                    width:
                                        screenWidth >
                                                600
                                            ? 120
                                            : 90,
                                    height:
                                        screenWidth >
                                                600
                                            ? 170
                                            : 130,
                                    fit:
                                        BoxFit.cover,
                                    errorBuilder: (context, error,
                                        stackTrace) {
                                      return Container(
                                        width:
                                            screenWidth >
                                                    600
                                                ? 120
                                                : 90,
                                        height:
                                            screenWidth >
                                                    600
                                                ? 170
                                                : 130,
                                        color:
                                            Colors
                                                .grey,
                                        child:
                                            const Icon(
                                          Icons.movie,
                                          size: 40,
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(
                                    width: 15),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        movie.title,
                                        maxLines: 2,
                                        overflow:
                                            TextOverflow
                                                .ellipsis,
                                        style:
                                            TextStyle(
                                          fontSize:
                                              screenWidth >
                                                      600
                                                  ? 24
                                                  : 20,
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),
                                      ),

                                      const SizedBox(
                                          height:
                                              10),

                                      Text(
                                        movie.year,
                                        style:
                                            const TextStyle(
                                          color:
                                              Colors
                                                  .grey,
                                          fontSize:
                                              16,
                                        ),
                                      ),

                                      const SizedBox(
                                          height:
                                              15),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal:
                                                  10,
                                              vertical:
                                                  5,
                                            ),
                                            decoration:
                                                BoxDecoration(
                                              color:
                                                  Colors
                                                      .red,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20),
                                            ),
                                            child:
                                                const Text(
                                              'MOVIE',
                                              style:
                                                  TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          IconButton(
                                            onPressed:
                                                () {
                                              vm.toggleFavorite(
                                                movie
                                                    .imdbId,
                                              );
                                            },
                                            icon:
                                                Icon(
                                              vm.isFavorite(
                                                      movie.imdbId)
                                                  ? Icons
                                                      .favorite
                                                  : Icons
                                                      .favorite_border,
                                              color:
                                                  Colors
                                                      .red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}