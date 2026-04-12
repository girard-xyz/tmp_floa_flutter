import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/domain/repositories/movie_repository.dart';
import 'package:movie_explorer/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_explorer/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:movie_explorer/presentation/blocs/movie_details/movie_details_event.dart';
import 'package:movie_explorer/presentation/blocs/movie_details/movie_details_state.dart';
import 'package:movie_explorer/presentation/widgets/error_view.dart';
import 'package:movie_explorer/core/di/injection.dart';
import 'package:movie_explorer/core/l10n/app_localizations.dart';

class MovieDetailsPage extends StatelessWidget {
  final String movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieDetailsBloc(getMovieDetailsUseCase: locator())
            ..add(LoadMovieDetails(movieId)),
      child: const _MovieDetailsView(),
    );
  }
}

class _MovieDetailsView extends StatelessWidget {
  const _MovieDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.amber),
            );
          } else if (state is MovieDetailsError) {
            return Scaffold(
              appBar: AppBar(title: const Text('Erreur')),
              body: ErrorView(
                message: state.message,
                onRetry: () {
                  final bloc = context.read<MovieDetailsBloc>();
                  // On relance avec le même ID
                  if (bloc.state is MovieDetailsError) {
                    // C'est un peu "hacky" d'ici mais on suppose qu'il y a qu'un ID par Page
                  }
                },
              ),
            );
          } else if (state is MovieDetailsLoaded) {
            final movie = state.movie;
            final hasBackdrop =
                movie.backdrop != null && movie.backdrop!.isNotEmpty;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      movie.title,
                      style: const TextStyle(
                        shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          hasBackdrop ? movie.backdrop! : movie.image,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, trace) =>
                              Container(color: Colors.grey[800]),
                        ),
                        // Gradient pour la lisibilité
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [Colors.black87, Colors.transparent],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (movie.image.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    movie.image,
                                    width: 100,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, err, constr) =>
                                        Container(
                                          width: 100,
                                          height: 150,
                                          color: Colors.grey[800],
                                        ),
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${movie.rating} / 10',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  if (movie.runtime != null)
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${movie.runtime} min',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 12),
                                  Text(
                                    movie.year,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        if (movie.genres != null &&
                            movie.genres!.isNotEmpty) ...[
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: movie.genres!
                                .map(
                                  (genre) => Chip(
                                    label: Text(genre),
                                    backgroundColor: Colors.white10,
                                    side: BorderSide.none,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 24),
                        ],
                        const Text(
                          'Synopsis',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          movie.overview ?? 'Aucun synopsis disponible.',
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 48), // Padding bas
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
