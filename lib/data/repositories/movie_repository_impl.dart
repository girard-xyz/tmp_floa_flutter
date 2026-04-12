import 'package:movie_explorer/domain/entities/movie.dart';
import 'package:movie_explorer/domain/repositories/movie_repository.dart';
import 'package:movie_explorer/data/datasources/movie_local_data_source.dart';
import 'package:movie_explorer/data/datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final String apiKey;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.apiKey,
  });

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      final remoteMovies = await remoteDataSource.getPopularMovies(
        apiKey,
        page: page,
      );
      if (page == 1) {
        // Ne mettre en cache que la page 1 (plus simple hors-ligne)
        await localDataSource.cachePopularMovies(remoteMovies);
      }
      return remoteMovies;
    } catch (e) {
      try {
        final localMovies = await localDataSource.getLastPopularMovies();
        return localMovies;
      } catch (cacheError) {
        throw Exception('Hors ligne et aucun cache disponible.');
      }
    }
  }

  // --- Favoris ---

  @override
  Future<List<Movie>> getFavorites() {
    return localDataSource.getFavorites();
  }

  @override
  Future<void> saveFavorite(Movie movie) {
    return localDataSource.saveFavorite(movie);
  }

  @override
  Future<void> removeFavorite(String movieId) {
    return localDataSource.removeFavorite(movieId);
  }
}
