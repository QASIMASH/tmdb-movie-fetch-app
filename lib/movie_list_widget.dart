// lib/movie_list_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'GatxController.dart';
import 'favouriteController.dart';
import 'main.dart';
import 'movie_model.dart';
import 'moviedetailspage.dart';

class MovieListWidget extends StatelessWidget {
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: Get.find<MovieController>().fetchMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return MoviesGridView(snapshot.data);
        }
      },
    );
  }
}

class MoviesGridView extends StatelessWidget {
  final List<Movie>? movies;

  MoviesGridView(this.movies);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isLandscape ? 4 : 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 2 / 3, // Adjust this ratio as needed
        ),
        itemCount: movies?.length ?? 0,
        itemBuilder: (context, index) {
          final movie = movies![index];
          return Expanded(child: MovieItemWidget(movie));
        },
      ),
    );
  }
}

class MovieItemWidget extends StatelessWidget {
  final Movie movie;

  MovieItemWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController =
        Get.find<FavoriteController>();

    return Obx(
      () => GestureDetector(
        onTap: () {
          // Navigate to the movie details page using GetX
          Get.to(() => MovieDetailsPage(movie));
        },
        child: Container(
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(4.0)),
                      child: Image.network(
                        movie.posterUrl,
                        fit: BoxFit.cover,
                        height: 100.0,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Release Date: ${movie.releaseDate}',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                favoriteController.isFavorite(movie)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                // Toggle favorite status
                                favoriteController.toggleFavorite(movie);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.live_tv,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Handle comment action
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.more_time_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Handle comment action
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
