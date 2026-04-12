import 'package:movie_explorer/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies({int page = 1});

  // --- Favoris ---
  Future<List<Movie>> getFavorites();
  Future<void> saveFavorite(Movie movie);
  Future<void> removeFavorite(String movieId);
}
