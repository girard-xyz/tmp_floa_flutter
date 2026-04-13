import 'package:flutter_test/flutter_test.dart';
import 'package:movie_explorer/domain/entities/movie.dart';
import 'package:movie_explorer/domain/repositories/movie_repository.dart';
import 'package:movie_explorer/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_event.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_state.dart';

// Mock Manuel du Usecase
class MockGetPopularMoviesUseCase extends GetPopularMoviesUseCase {
  MockGetPopularMoviesUseCase() : super(_DummyRepository());

  bool shouldThrowError = false;
  List<Movie> mockMovies = [];

  @override
  Future<List<Movie>> call({int page = 1}) async {
    if (shouldThrowError) {
      throw Exception('Erreur API simulée');
    }
    return mockMovies;
  }
}

class _DummyRepository implements MovieRepository {
  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async => [];

  @override
  Future<Movie> getMovieDetails(String movieId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getFavorites() async => [];

  @override
  Future<void> removeFavorite(String movieId) async {}

  @override
  Future<void> saveFavorite(Movie movie) async {}
}

void main() {
  late PopularMoviesBloc bloc;
  late MockGetPopularMoviesUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetPopularMoviesUseCase();
    bloc = PopularMoviesBloc(getPopularMoviesUseCase: mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  const tMovie = Movie(
    id: '1',
    title: 'Test',
    year: '2024',
    image: 'url',
    rating: '5',
  );

  test('initial state should be PopularMoviesInitial', () {
    expect(bloc.state, equals(PopularMoviesInitial()));
  });

  test(
    'should emit [Loading, Loaded] when data is retrieved successfully',
    () async {
      // Arrange
      mockUseCase.mockMovies = [tMovie];

      // Assert Later (Subscribe to state stream before emitting event)
      final expectedResponse = [
        PopularMoviesLoading(),
        const PopularMoviesLoaded(movies: [tMovie]),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedResponse));

      // Act
      bloc.add(FetchPopularMovies());
    },
  );

  test('should emit [Loading, Error] when an exception is thrown', () async {
    // Arrange
    mockUseCase.shouldThrowError = true;

    // Assert Later
    final expectedResponse = [
      PopularMoviesLoading(),
      const PopularMoviesError('Exception: Erreur API simulée'),
    ];

    expectLater(bloc.stream, emitsInOrder(expectedResponse));

    // Act
    bloc.add(FetchPopularMovies());
  });
}
