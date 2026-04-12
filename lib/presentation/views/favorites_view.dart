import 'package:flutter/material.dart';
import 'package:movie_explorer/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movie.dart';
import 'package:movie_explorer/presentation/blocs/favorites_bloc.dart';
import 'package:movie_explorer/presentation/blocs/favorites_state.dart';
import 'package:movie_explorer/presentation/widgets/error_view.dart';
import 'package:movie_explorer/presentation/widgets/movie_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      // Très important : On empeche le bloc builder de reconstruire TOUT le composant
      // quand une carte est ajoutée ou supprimée, SAUF si le nombre passe de 0 à 1 ou 1 à 0
      // pour gérer les transitions vers le message "Vide".
      buildWhen: (previous, current) {
        if (previous is FavoritesLoaded && current is FavoritesLoaded) {
          if (previous.favorites.isEmpty != current.favorites.isEmpty)
            return true;
          return false;
        }
        return true;
      },
      builder: (context, state) {
        Widget content = const SizedBox.shrink(key: ValueKey('empty_fav'));

        if (state is FavoritesLoading) {
          content = const Center(
            key: ValueKey('loading_fav'),
            child: CircularProgressIndicator(color: Colors.redAccent),
          );
        } else if (state is FavoritesError) {
          content = ErrorView(
            key: const ValueKey('error_fav'),
            message: state.message,
            onRetry: () {},
          );
        } else if (state is FavoritesLoaded) {
          if (state.favorites.isEmpty) {
            content = Center(
              key: const ValueKey('no_data_fav'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.white54),
                  SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.noFavoritesYet,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            );
          } else {
            content = AnimatedFavoritesGrid(
              key: const ValueKey('animated_grid_fav'),
              initialFavorites: state.favorites,
            );
          }
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: content,
        );
      },
    );
  }
}

// Widget Stateful qui gère l'animation fine des retraits/ajouts
class AnimatedFavoritesGrid extends StatefulWidget {
  final List<Movie> initialFavorites;
  const AnimatedFavoritesGrid({super.key, required this.initialFavorites});

  @override
  State<AnimatedFavoritesGrid> createState() => _AnimatedFavoritesGridState();
}

class _AnimatedFavoritesGridState extends State<AnimatedFavoritesGrid> {
  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
  late List<Movie> _currentMovies;

  @override
  void initState() {
    super.initState();
    _currentMovies = List.from(widget.initialFavorites);
  }

  @override
  Widget build(BuildContext context) {
    // Le BlocListener écoute en silence et déclenche les animations
    return BlocListener<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesLoaded) {
          final newMovies = state.favorites;

          // 1. Trouver et animer les retraits
          for (int i = _currentMovies.length - 1; i >= 0; i--) {
            if (!newMovies.contains(_currentMovies[i])) {
              final removedMovie = _currentMovies.removeAt(i);
              _gridKey.currentState?.removeItem(
                i,
                (context, animation) => _buildItem(removedMovie, animation),
                duration: const Duration(milliseconds: 300),
              );
            }
          }

          // 2. Trouver et animer les ajouts
          for (int i = 0; i < newMovies.length; i++) {
            if (i >= _currentMovies.length) {
              _currentMovies.add(newMovies[i]);
              _gridKey.currentState?.insertItem(
                i,
                duration: const Duration(milliseconds: 300),
              );
            } else if (_currentMovies[i].id != newMovies[i].id) {
              _currentMovies.insert(i, newMovies[i]);
              _gridKey.currentState?.insertItem(
                i,
                duration: const Duration(milliseconds: 300),
              );
            }
          }
        }
      },
      child: AnimatedGrid(
        key: _gridKey,
        padding: const EdgeInsets.all(16),
        initialItemCount: _currentMovies.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index, animation) {
          if (index >= _currentMovies.length) return const SizedBox();
          return _buildItem(_currentMovies[index], animation);
        },
      ),
    );
  }

  Widget _buildItem(Movie movie, Animation<double> animation) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      child: FadeTransition(
        opacity: animation,
        child: MovieCard(movie: movie),
      ),
    );
  }
}
