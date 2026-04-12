import 'package:flutter_test/flutter_test.dart';
import 'package:movie_explorer/domain/entities/movie.dart';
import 'package:movie_explorer/domain/repositories/movie_repository.dart';
import 'package:movie_explorer/domain/usecases/favorites_usecases.dart';
import 'package:movie_explorer/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:movie_explorer/presentation/blocs/favorites/favorites_event.dart';
import 'package:movie_explorer/presentation/blocs/favorites/favorites_state.dart';

class FakeMovieRepository implements MovieRepository {
  List<Movie> mockFavorites = [];
  bool shouldThrow = false;

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async => [];

  @override
  Future<List<Movie>> getFavorites() async {
    if (shouldThrow) throw Exception('Storage error');
    return mockFavorites.toList();
  }

  @override
  Future<Movie> getMovieDetails(String movieId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> saveFavorite(Movie movie) async {
    if (shouldThrow) throw Exception('Storage error');
    final exists = mockFavorites.any(
      (existingMovie) => existingMovie.id == movie.id,
    );
    if (!exists) mockFavorites.add(movie);
  }

  @override
  Future<void> removeFavorite(String movieId) async {
    if (shouldThrow) throw Exception('Storage error');
    mockFavorites.removeWhere((existingMovie) => existingMovie.id == movieId);
  }
}

void main() {
  late FavoritesBloc bloc;
  late FakeMovieRepository fakeRepo;

  final testMovie = const Movie(
    id: "1",
    title: "Inception",
    year: "2010",
    image: "poster.jpg",
    rating: "8.8",
  );

  setUp(() {
    fakeRepo = FakeMovieRepository();
    bloc = FavoritesBloc(
      getFavorites: GetFavoritesUseCase(fakeRepo),
      saveFavorite: SaveFavoriteUseCase(fakeRepo),
      removeFavorite: RemoveFavoriteUseCase(fakeRepo),
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('Initial state should be FavoritesLoading', () {
    expect(bloc.state, isA<FavoritesLoading>());
  });

  test('LoadFavorites emit Loading then Loaded with empty list', () async {
    expectLater(
      bloc.stream,
      emitsInOrder([
        isA<FavoritesLoaded>().having(
          (state) => state.favorites.isEmpty,
          'isEmpty',
          true,
        ),
      ]),
    );
    bloc.add(LoadFavorites());
  });

  test('ToggleFavoriteEvent emit Loaded state with movie added', () async {
    // Initial fetch
    bloc.add(LoadFavorites());
    await Future.delayed(Duration.zero);

    expectLater(
      bloc.stream,
      emitsInOrder([
        isA<FavoritesLoaded>().having(
          (state) => state.favorites.length,
          'length',
          1,
        ),
      ]),
    );

    bloc.add(ToggleFavoriteEvent(testMovie)); // Adds because it's not present
  });

  test('ToggleFavoriteEvent emit Loaded state with movie removed', () async {
    // Injecter initialement
    fakeRepo.mockFavorites = [testMovie];
    bloc.add(LoadFavorites());
    await Future.delayed(Duration.zero);

    // L'attente native pour la séquence complète
    expectLater(
      bloc.stream,
      emitsInOrder([
        isA<FavoritesLoaded>().having(
          (state) => state.favorites.isEmpty,
          'is now empty',
          true,
        ),
      ]),
    );

    bloc.add(
      ToggleFavoriteEvent(testMovie),
    ); // Removes it because it's already present
  });

  test('LoadFavorites emit Error when repository throws', () async {
    fakeRepo.shouldThrow = true;

    expectLater(bloc.stream, emitsInOrder([isA<FavoritesError>()]));

    bloc.add(LoadFavorites());
  });
}
