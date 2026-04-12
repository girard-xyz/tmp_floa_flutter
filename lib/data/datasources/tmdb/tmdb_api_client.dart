import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movie_explorer/data/models/tmdb/tmdb_movie_model.dart';

part 'tmdb_api_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class TmdbApiClient {
  factory TmdbApiClient(Dio dio, {String baseUrl}) = _TmdbApiClient;

  @GET("/movie/popular?language=fr-FR")
  Future<TmdbResponse> getPopularMovies(@Header("Authorization") String token);
}
