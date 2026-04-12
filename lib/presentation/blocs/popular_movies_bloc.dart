import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_popular_movies_usecase.dart';
import 'popular_movies_event.dart';
import 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;

  PopularMoviesBloc({required this.getPopularMoviesUseCase}) : super(PopularMoviesInitial()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());
      try {
        final movies = await getPopularMoviesUseCase();
        emit(PopularMoviesLoaded(movies));
      } catch (e) {
        emit(PopularMoviesError(e.toString()));
      }
    });
  }
}
