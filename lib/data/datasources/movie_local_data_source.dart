import 'package:movie_explorer/domain/entities/movie.dart';

abstract class MovieLocalDataSource {
  /// Récupère la dernière liste de films mise en cache
  Future<List<Movie>> getLastPopularMovies();

  /// Sauvegarde la nouvelle liste de films en cache
  Future<void> cachePopularMovies(List<Movie> movies);

  // --- Favoris ---
  Future<List<Movie>> getFavorites();
  Future<void> saveFavorite(Movie movie);
  Future<void> removeFavorite(String movieId);
}
