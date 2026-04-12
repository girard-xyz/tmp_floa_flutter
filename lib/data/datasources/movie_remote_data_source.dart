import 'package:movie_explorer/domain/entities/movie.dart';

/// Interface commune pour toutes nos sources de données distantes (IMDB, OMDB, etc.)
/// Cela permet au Repository de ne pas se soucier de l'API utilisée !
abstract class MovieRemoteDataSource {
  Future<List<Movie>> getPopularMovies(String apiKey, {int page = 1});
}
