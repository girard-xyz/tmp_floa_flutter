import 'package:flutter_test/flutter_test.dart';
import 'package:movie_explorer/data/datasources/tmdb/tmdb_api_client.dart';
import 'package:movie_explorer/data/datasources/tmdb/tmdb_remote_data_source_impl.dart';
import 'package:movie_explorer/data/models/tmdb/tmdb_movie_model.dart';
import 'package:dio/dio.dart';

class FakeTmdbApiClient implements TmdbApiClient {
  bool shouldThrow = false;
  TmdbResponse? mockResponse;

  @override
  Future<TmdbResponse> getPopularMovies(String token, {int page = 1}) async {
    if (shouldThrow) {
      throw DioException(requestOptions: RequestOptions(path: '/mock'));
    }

    if (mockResponse != null) return mockResponse!;

    return TmdbResponse(
      results: [
        TmdbMovieModel(
          id: 123,
          title: "Fake TMDB Movie",
          releaseDate: "2024-01-01",
          posterPath: "/fake.jpg",
          voteAverage: 8.5,
        ),
      ],
    );
  }

  @override
  Future<TmdbMovieModel> getMovieDetails(String token, String movieId) async {
    throw UnimplementedError();
  }
}

void main() {
  late TmdbRemoteDataSourceImpl dataSource;
  late FakeTmdbApiClient fakeApiClient;

  setUp(() {
    fakeApiClient = FakeTmdbApiClient();
    dataSource = TmdbRemoteDataSourceImpl(fakeApiClient);
  });

  test(
    'getPopularMovies returns properly mapped entities from TMDB Models',
    () async {
      final movies = await dataSource.getPopularMovies("fakeToken");

      expect(movies.length, 1);
      expect(movies.first.id, "123");
      expect(movies.first.title, "Fake TMDB Movie");
      expect(movies.first.rating, "8.5");
      expect(
        movies.first.image,
        "https://image.tmdb.org/t/p/w500/fake.jpg",
        reason: "Mappe auto l'url de l'image",
      );
    },
  );

  test(
    'getPopularMovies throws exception seamlessly if ApiClient throws',
    () async {
      fakeApiClient.shouldThrow = true;
      expect(() => dataSource.getPopularMovies("fakeToken"), throwsException);
    },
  );

  test('getPopularMovies maps cleanly an empty response array', () async {
    fakeApiClient.mockResponse = TmdbResponse(results: []);

    final movies = await dataSource.getPopularMovies("fakeToken");
    expect(movies.isEmpty, isTrue);
  });
}
