import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_local_data_source.dart';
import '../datasources/movie_remote_data_source.dart';

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
  Future<List<Movie>> getPopularMovies() async {
    try {
      // 1. On tente toujours de récupérer la donnée up-to-date sur le réseau
      final remoteMovies = await remoteDataSource.getPopularMovies(apiKey);
      
      // 2. Si succès, on met à jour le cache silencieusement
      await localDataSource.cachePopularMovies(remoteMovies);
      
      return remoteMovies;
    } catch (e) {
      // 3. En cas d'erreur (pas d'internet, serveur inaccessible...)
      try {
        // On tente de renvoyer le cache !
        final localMovies = await localDataSource.getLastPopularMovies();
        return localMovies;
      } catch (cacheError) {
        // 4. Si le cache est vide et pas de réseau, on remonte l'erreur
        throw Exception('Hors ligne et aucun cache disponible.');
      }
    }
  }
}

