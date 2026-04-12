import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'imdb_api_client.g.dart';

@RestApi(baseUrl: "https://imdb-api.com/en/API")
abstract class ImdbApiClient {
  factory ImdbApiClient(Dio dio, {String baseUrl}) = _ImdbApiClient;

  @GET("/MostPopularMovies/{apiKey}")
  Future<dynamic> getPopularMovies(@Path("apiKey") String apiKey);
}
