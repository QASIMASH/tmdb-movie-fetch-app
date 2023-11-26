// lib\favouriteController.dart
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GatxController.dart';
import 'movie_model.dart';

class FavoriteController extends GetxController {
  RxList<Movie> favorites = <Movie>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize favorites from shared preferences
    _loadFavorites();
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favoriteMovies');

    if (favoriteIds != null) {
      favorites.assignAll(favoriteIds.map((id) {
        // Find the corresponding movie from the list of all movies
        return Get.find<MovieController>()
            .movies
            .firstWhere((movie) => movie.id == id);
      }).toList());
    }
  }

  void _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> favoriteIds = favorites.map((movie) => movie.id).toList();
    prefs.setStringList('favoriteMovies', favoriteIds.cast<String>());
  }

  void toggleFavorite(Movie movie) {
    if (favorites.contains(movie)) {
      favorites.remove(movie);
      print('Removed from favorites: ${movie.title}');
    } else {
      favorites.add(movie);
      print('Added to favorites: ${movie.title}');
    }

    // Save favorites to shared preferences
    _saveFavorites();

    // Trigger UI update
    update();
  }

  bool isFavorite(Movie movie) {
    return favorites.contains(movie);
  }
}
