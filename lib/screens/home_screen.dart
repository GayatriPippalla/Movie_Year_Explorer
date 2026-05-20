import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/movie_viewmodel.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    final vm =
    context.watch<MovieViewModel>();

    return Scaffold(

      appBar: AppBar(

        title: const Text(

          'Movie Year Explorer',

          style: TextStyle(

            fontWeight:
            FontWeight.bold,

            letterSpacing: 1,
          ),
        ),
      ),

      body: Column(

        children: [

          // SEARCH BAR
          Padding(

            padding:
            const EdgeInsets.all(12),

            child: TextField(

              keyboardType:
              TextInputType.number,

              maxLength: 4,

              onChanged: (value) {

                vm.onSearchChanged(value);
              },

              decoration: InputDecoration(

                counterText: '',

                hintText:
                'Enter release year (2025)',

                hintStyle:
                const TextStyle(
                  color: Colors.grey,
                ),

                prefixIcon:
                const Icon(
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

                    child:
                    CircularProgressIndicator(),
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

                  return const Center(

                    child: Column(

                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        Text(

                          'Search movies by year',

                          style: TextStyle(

                            fontSize: 24,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(

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

                  onNotification:
                      (scrollInfo) {

                    if (scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent - 200) {

                      vm.loadMore();
                    }

                    return true;
                  },

                  child: ListView.builder(

                    itemCount:
                    vm.movies.length + 1,

                    itemBuilder:
                        (_, index) {

                      // PAGINATION LOADER
                      if (index ==
                          vm.movies.length) {

                        return vm
                            .isPaginationLoading

                            ? const Padding(

                          padding:
                          EdgeInsets.all(20),

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
                            BorderRadius.circular(16),
                          ),

                          margin:
                          const EdgeInsets.symmetric(

                            horizontal: 12,

                            vertical: 8,
                          ),

                          child: Padding(

                            padding:
                            const EdgeInsets.all(10),

                            child: Row(

                              children: [

                                // POSTER
                                ClipRRect(

                                  borderRadius:
                                  BorderRadius.circular(12),

                                  child: Image.network(

                                    movie.poster,

                                    width: 90,

                                    height: 130,

                                    fit: BoxFit.cover,

                                    errorBuilder:
                                        (_, __, ___) {

                                      return Container(

                                        width: 90,

                                        height: 130,

                                        color: Colors.grey,

                                        child: const Icon(
                                          Icons.movie,
                                          size: 40,
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(width: 15),

                                Expanded(

                                  child: Column(

                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                    children: [

                                      Text(

                                        movie.title,

                                        maxLines: 2,

                                        overflow:
                                        TextOverflow.ellipsis,

                                        style:
                                        const TextStyle(

                                          fontSize: 20,

                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      Text(

                                        movie.year,

                                        style:
                                        const TextStyle(

                                          color:
                                          Colors.grey,

                                          fontSize: 16,
                                        ),
                                      ),

                                      const SizedBox(height: 15),

                                      Row(

                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,

                                        children: [

                                          // MOVIE BADGE
                                          Container(

                                            padding:
                                            const EdgeInsets.symmetric(

                                              horizontal: 10,

                                              vertical: 5,
                                            ),

                                            decoration: BoxDecoration(

                                              color:
                                              Colors.red,

                                              borderRadius:
                                              BorderRadius.circular(20),
                                            ),

                                            child: const Text(

                                              'MOVIE',

                                              style:
                                              TextStyle(

                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          // FAVORITE BUTTON
                                          IconButton(

                                            onPressed: () {

                                              vm.toggleFavorite(
                                                movie.imdbId,
                                              );
                                            },

                                            icon: Icon(

                                              vm.isFavorite(movie.imdbId)

                                                  ? Icons.favorite
                                                  : Icons.favorite_border,

                                              color: Colors.red,
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