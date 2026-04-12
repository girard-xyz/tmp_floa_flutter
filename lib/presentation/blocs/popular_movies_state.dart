import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  final List<Movie> movies;
  final int page;
  final bool hasReachedMax;

  const PopularMoviesLoaded({
    required this.movies,
    this.page = 1,
    this.hasReachedMax = false,
  });

  PopularMoviesLoaded copyWith({
    List<Movie>? movies,
    int? page,
    bool? hasReachedMax,
  }) {
    return PopularMoviesLoaded(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [movies, page, hasReachedMax];
}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  const PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
