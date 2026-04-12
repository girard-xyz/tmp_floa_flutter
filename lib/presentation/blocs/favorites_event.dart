import 'package:equatable/equatable.dart';
import 'package:movie_explorer/domain/entities/movie.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavoriteEvent extends FavoritesEvent {
  final Movie movie;
  const ToggleFavoriteEvent(this.movie);

  @override
  List<Object> get props => [movie];
}
