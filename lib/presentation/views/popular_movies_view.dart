import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies_bloc.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies_event.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies_state.dart';
import 'package:movie_explorer/presentation/widgets/error_view.dart';
import 'package:movie_explorer/presentation/widgets/movie_card.dart';

class PopularMoviesView extends StatelessWidget {
  const PopularMoviesView({super.key});

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
            content = const Center(
              key: ValueKey('no_data'),
              child: Text(
                "Aucun film trouvé.",
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
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
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
