import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'movie_model.dart';
import 'movie_service.dart';

class MovieController extends GetxController {
  RxList<Movie> movies = <Movie>[].obs;

  // Add a static instance method
  static MovieController get instance => Get.find<MovieController>();

  Future<List<Movie>> fetchMovies() async {
    try {
      final List<Movie> fetchedMovies = await MovieService().fetchMovies();
      movies.value = fetchedMovies;
      return fetchedMovies; // Return the list of movies
    } catch (e) {
      print('Error fetching movies: $e');
      throw e; // Rethrow the exception
    }
  }
}
