import 'package:equatable/equatable.dart';
import 'package:movie_explorer/domain/entities/movie.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object> get props => [];
}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Movie> favorites;
  final Movie? lastToggledMovie;
  final bool? isAdded;

  const FavoritesLoaded(this.favorites, {this.lastToggledMovie, this.isAdded});

  @override
  List<Object> get props => [
    favorites,
    ?lastToggledMovie,
    ?isAdded,
  ];

  // Utilitaire très pratique pour la UI
  bool isFavorite(String id) => favorites.any((movie) => movie.id == id);
}

class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}
