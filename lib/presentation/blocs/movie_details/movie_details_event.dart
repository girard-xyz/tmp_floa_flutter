import 'package:equatable/equatable.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieDetails extends MovieDetailsEvent {
  final String movieId;

  const LoadMovieDetails(this.movieId);

  @override
  List<Object> get props => [movieId];
}
