import 'package:movie_explorer/domain/entities/movie.dart';
import 'package:movie_explorer/domain/repositories/movie_repository.dart';

class GetFavoritesUseCase {
  final MovieRepository repository;
  GetFavoritesUseCase(this.repository);

  Future<List<Movie>> call() {
    return repository.getFavorites();
  }
}

class SaveFavoriteUseCase {
  final MovieRepository repository;
  SaveFavoriteUseCase(this.repository);

  Future<void> call(Movie movie) {
    return repository.saveFavorite(movie);
  }
}

class RemoveFavoriteUseCase {
  final MovieRepository repository;
  RemoveFavoriteUseCase(this.repository);

  Future<void> call(String movieId) {
    return repository.removeFavorite(movieId);
  }
}
