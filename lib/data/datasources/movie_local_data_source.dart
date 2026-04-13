import 'package:movie_explorer/domain/entities/movie.dart';

abstract class MovieLocalDataSource {
  // --- Favoris ---
  Future<List<Movie>> getFavorites();
  Future<void> saveFavorite(Movie movie);
  Future<void> removeFavorite(String movieId);
}
