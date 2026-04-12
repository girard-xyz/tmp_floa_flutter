import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movie_explorer/data/models/omdb/omdb_movie_model.dart';

part 'omdb_api_client.g.dart';

@RestApi(baseUrl: "http://www.omdbapi.com/")
abstract class OmdbApiClient {
  factory OmdbApiClient(Dio dio, {String baseUrl}) = _OmdbApiClient;

  @GET("/")
  Future<OmdbResponse> searchMovies(
    @Query("apikey") String apiKey,
    @Query("s") String searchQuery,
    @Query("type") String type,
  );
}
