// favouritemovie.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'GatxController.dart';
import 'favouriteController.dart';
import 'movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'moviedetailspage.dart';

// FavoriteScreen
class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  final MovieController movieController = MovieController.instance;
  @override
  void initState() {
    super.initState();
    // Additional initialization if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => favoriteController.favorites.isEmpty
            ? Center(
                child: Text('No favorite movies yet.'),
              )
            : ListView.builder(
                itemCount: favoriteController.favorites.length,
                itemBuilder: (context, index) {
                  final movie = favoriteController.favorites[index];
                  return FavoriteMovieCard(movie, favoriteController);
                },
              ),
      ),
    );
  }
}

class FavoriteMovieCard extends StatelessWidget {
  final Movie movie;
  final FavoriteController favoriteController;

  FavoriteMovieCard(this.movie, this.favoriteController);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the movie details page using GetX
        // For simplicity, you can replace this with your navigation logic
        // Get.to(() => MovieDetailsPage(movie));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
                child: Image.network(
                  movie.posterUrl,
                  fit: BoxFit.cover,
                  height: 150.0,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    // Remove from favorites
                    favoriteController.toggleFavorite(movie);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                Text(
                  movie.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 13.0),
                Text(
                  'Release Date: ${movie.releaseDate}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
