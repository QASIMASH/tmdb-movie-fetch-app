// movie_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'movie_model.dart';

class MovieService {
  static const String _apiKey = 'aff58f87c6905b9447e576926575f14d';

  static const String _baseUrl = 'https://api.themoviedb.org/3/discover/movie';

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      return results.map((movieData) => Movie.fromJson(movieData)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
