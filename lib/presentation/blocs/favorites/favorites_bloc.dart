import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/presentation/blocs/favorites/favorites_event.dart';
import 'package:movie_explorer/presentation/blocs/favorites/favorites_state.dart';
import 'package:movie_explorer/domain/usecases/favorites_usecases.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUseCase getFavorites;
  final SaveFavoriteUseCase saveFavorite;
  final RemoveFavoriteUseCase removeFavorite;

  FavoritesBloc({
    required this.getFavorites,
    required this.saveFavorite,
    required this.removeFavorite,
  }) : super(FavoritesLoading()) {
    on<LoadFavorites>((event, emit) async {
      try {
        final favorites = await getFavorites();
        emit(FavoritesLoaded(favorites));
      } catch (e) {
        emit(FavoritesError('Erreur chargement favoris: $e'));
      }
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      if (state is FavoritesLoaded) {
        final currentState = state as FavoritesLoaded;
        final isFav = currentState.isFavorite(event.movie.id);

        try {
          if (isFav) {
            await removeFavorite(event.movie.id);
          } else {
            await saveFavorite(event.movie);
          }
          // On rafraîchit la liste pour avoir l'état correct
          final newFavorites = await getFavorites();
          emit(FavoritesLoaded(newFavorites));
        } catch (e) {
          // Si on veut être strict, on pourrait émettre une erreur,
          // mais on laisse l'état intact pour la fluidité
        }
      } else {
        // Fallback si la liste n'a pas encore été chargée, on l'ajoute directement (edge case)
        try {
          await saveFavorite(event.movie);
          final newFavorites = await getFavorites();
          emit(FavoritesLoaded(newFavorites));
        } catch (_) {}
      }
    });
  }
}
