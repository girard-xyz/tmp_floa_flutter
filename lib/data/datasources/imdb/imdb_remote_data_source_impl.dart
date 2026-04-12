import 'package:movie_explorer/domain/entities/movie.dart';
import 'package:movie_explorer/data/datasources/movie_remote_data_source.dart';
import 'package:movie_explorer/data/datasources/imdb/imdb_api_client.dart';

class ImdbRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ImdbApiClient apiClient;

  ImdbRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Movie> getMovieDetails(String apiKey, String movieId) async {
    throw UnimplementedError('IMDB not fully implemented yet');
  }

  @override
  Future<List<Movie>> getPopularMovies(String apiKey, {int page = 1}) async {
    throw UnimplementedError();
  }
}
