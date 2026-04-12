import 'package:movie_explorer/domain/entities/movie.dart';
import 'package:movie_explorer/data/datasources/movie_remote_data_source.dart';
import 'package:movie_explorer/data/datasources/tmdb/tmdb_api_client.dart';

class TmdbRemoteDataSourceImpl implements MovieRemoteDataSource {
  final TmdbApiClient apiClient;

  TmdbRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Movie> getMovieDetails(String apiKey, String movieId) async {
    final response = await apiClient.getMovieDetails('Bearer $apiKey', movieId);
    return response.toEntity();
  }

  @override
  Future<List<Movie>> getPopularMovies(String apiKey, {int page = 1}) async {
    // TMDB Attend un header d'autorisation de type Bearer
    final response = await apiClient.getPopularMovies(
      "Bearer $apiKey",
      page: page,
    );

    // On map explicitement nos DTOs en Entités du Domaine
    return response.results.map((model) => model.toEntity()).toList();
  }
}
