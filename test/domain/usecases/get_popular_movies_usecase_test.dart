import 'package:flutter_test/flutter_test.dart';
import 'package:movie_explorer/domain/entities/movie.dart';
import 'package:movie_explorer/domain/repositories/movie_repository.dart';
import 'package:movie_explorer/domain/usecases/get_popular_movies_usecase.dart';

// Mock Manuel du Repository sans package tiers (zero dependances)
class MockMovieRepository implements MovieRepository {
  List<Movie> mockMoviesToReturn = [];

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    return mockMoviesToReturn;
  }

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
  late GetPopularMoviesUseCase usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    // Le Usecase est instancié avec notre faux repository
    usecase = GetPopularMoviesUseCase(mockRepository);
  });

  const tMovie = Movie(
    id: '1',
    title: 'Film Test',
    year: '2024',
    image: 'url_image',
    rating: '5',
  );

  test('doit récupérer la liste de films depuis le repository', () async {
    // Arrange (Préparation)
    mockRepository.mockMoviesToReturn = [tMovie];

    // Act (Action)
    final result = await usecase();

    // Assert (Vérification)
    expect(result, equals([tMovie]));
  });
}
