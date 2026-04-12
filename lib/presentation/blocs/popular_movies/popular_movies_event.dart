import 'package:equatable/equatable.dart';

abstract class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularMovies extends PopularMoviesEvent {}

class LoadMorePopularMovies extends PopularMoviesEvent {}
