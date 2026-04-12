import 'package:flutter/material.dart';
import 'package:movie_explorer/core/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_event.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_state.dart';
import 'package:movie_explorer/presentation/widgets/error_view.dart';
import 'package:movie_explorer/presentation/widgets/movie_card.dart';

class PopularMoviesView extends StatefulWidget {
  const PopularMoviesView({super.key});

  @override
  State<PopularMoviesView> createState() => _PopularMoviesViewState();
}

class _PopularMoviesViewState extends State<PopularMoviesView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PopularMoviesBloc>().add(LoadMorePopularMovies());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      builder: (context, state) {
        Widget content = const SizedBox.shrink(key: ValueKey('empty'));

        if (state is PopularMoviesLoading || state is PopularMoviesInitial) {
          content = const Center(
            key: ValueKey('loading'),
            child: CircularProgressIndicator(color: Colors.amber),
          );
        } else if (state is PopularMoviesError) {
          content = ErrorView(
            key: const ValueKey('error'),
            message: state.message,
            onRetry: () {
              context.read<PopularMoviesBloc>().add(FetchPopularMovies());
            },
          );
        } else if (state is PopularMoviesLoaded) {
          if (state.movies.isEmpty) {
            content = Center(
              key: const ValueKey('no_data'),
              child: Text(
                AppLocalizations.of(context)!.noMoviesFound,
                style: TextStyle(color: Colors.white70),
              ),
            );
          } else {
            content = RefreshIndicator(
              key: const ValueKey('loaded_grid'),
              color: Colors.amber,
              backgroundColor: const Color(0xFF202020),
              onRefresh: () async {
                context.read<PopularMoviesBloc>().add(FetchPopularMovies());
              },
              child: GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                // +1 pour rajouter un carré de loader si on a pas atteint la fin !
                itemCount: state.movies.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.movies.length) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    );
                  }
                  return MovieCard(movie: state.movies[index]);
                },
              ),
            );
          }
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: content,
        );
      },
    );
  }
}
