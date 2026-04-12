import 'package:movie_explorer/domain/entities/movie.dart';
import 'package:movie_explorer/domain/repositories/movie_repository.dart';

class GetPopularMoviesUseCase {
  final MovieRepository repository;

  GetPopularMoviesUseCase(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getPopularMovies();
  }
}
