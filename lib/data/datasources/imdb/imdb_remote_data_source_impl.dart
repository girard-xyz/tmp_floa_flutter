import '../../../domain/entities/movie.dart';
import '../movie_remote_data_source.dart';
import 'imdb_api_client.dart';

class ImdbRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ImdbApiClient apiClient;

  ImdbRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<Movie>> getPopularMovies(String apiKey) async {
    final response = await apiClient.getPopularMovies(apiKey);
    return response.items;
  }
}
