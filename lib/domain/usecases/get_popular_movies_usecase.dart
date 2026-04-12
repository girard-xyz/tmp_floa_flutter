import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetPopularMoviesUseCase {
  final MovieRepository repository;

  GetPopularMoviesUseCase(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getPopularMovies();
  }
}
