import 'package:movie_explorer/domain/entities/movie.dart';
import 'package:movie_explorer/data/datasources/movie_remote_data_source.dart';
import 'package:movie_explorer/data/datasources/omdb/omdb_api_client.dart';

class OmdbRemoteDataSourceImpl implements MovieRemoteDataSource {
  final OmdbApiClient apiClient;

  OmdbRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<Movie>> getPopularMovies(String apiKey) async {
    // OMDB n'a pas de top global "popular", nous simulons en cherchant un mot-clé populaire.
    final response = await apiClient.searchMovies(apiKey, "The", "movie");

    // Si la recherche ne retourne rien, search vaut null. On gère ce cas.
    if (response.search == null) {
      return [];
    }

    // Le cast vers List<Movie> fonctionne car OmdbMovieModel étend Movie.
    return response.search!;
  }
}
