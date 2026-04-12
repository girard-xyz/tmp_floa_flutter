import '../../../domain/entities/movie.dart';
import '../movie_remote_data_source.dart';
import 'tmdb_api_client.dart';

class TmdbRemoteDataSourceImpl implements MovieRemoteDataSource {
  final TmdbApiClient apiClient;

  TmdbRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<Movie>> getPopularMovies(String apiKey) async {
    // TMDB Attend un header d'autorisation de type Bearer
    final response = await apiClient.getPopularMovies("Bearer $apiKey");
    
    // On map explicitement nos DTOs en Entités du Domaine
    return response.results.map((model) => model.toEntity()).toList();
  }
}
