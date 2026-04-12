import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_event.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  bool _isFetching = false;

  PopularMoviesBloc({required this.getPopularMoviesUseCase})
    : super(PopularMoviesInitial()) {
    // Premier chargement de la page 1 ou rafraichissement forcé (Pull-To-Refresh)
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());
      try {
        final movies = await getPopularMoviesUseCase(page: 1);
        emit(
          PopularMoviesLoaded(
            movies: movies,
            page: 1,
            hasReachedMax: movies.isEmpty,
          ),
        );
      } catch (e) {
        emit(PopularMoviesError(e.toString()));
      }
    });

    // Pagination gérée dynamiquement
    on<LoadMorePopularMovies>((event, emit) async {
      if (state is PopularMoviesLoaded) {
        final currentState = state as PopularMoviesLoaded;
        if (currentState.hasReachedMax || _isFetching) return;

        _isFetching = true;
        try {
          final nextPage = currentState.page + 1;
          final newMovies = await getPopularMoviesUseCase(page: nextPage);

          if (newMovies.isEmpty) {
            emit(currentState.copyWith(hasReachedMax: true));
          } else {
            // Concatener la nouvelle liste
            emit(
              currentState.copyWith(
                movies: List.of(currentState.movies)..addAll(newMovies),
                page: nextPage,
                hasReachedMax: false,
              ),
            );
          }
        } catch (e) {
          // En cas de perte réseau discrète au scroll, on ne crashe pas la liste existante
        } finally {
          _isFetching = false;
        }
      }
    });
  }
}
