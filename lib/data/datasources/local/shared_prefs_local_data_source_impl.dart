import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../domain/entities/movie.dart';
import '../../models/local/local_movie_model.dart';
import '../movie_local_data_source.dart';

const cachedPopularMoviesStr = 'CACHED_POPULAR_MOVIES';

class SharedPrefsLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences sharedPreferences;

  SharedPrefsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<Movie>> getLastPopularMovies() {
    final jsonString = sharedPreferences.getString(cachedPopularMoviesStr);
    
    if (jsonString != null) {
      final List<dynamic> decodedJson = json.decode(jsonString);
      final List<LocalMovieModel> localMovies = decodedJson
          .map((e) => LocalMovieModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Future.value(localMovies);
    } else {
      throw Exception('Aucun film en cache trouvé');
    }
  }

  @override
  Future<void> cachePopularMovies(List<Movie> movies) {
    final List<LocalMovieModel> localMovies = movies
        .map((movie) => LocalMovieModel.fromEntity(movie))
        .toList();
        
    final List<Map<String, dynamic>> jsonList = localMovies
        .map((localModel) => localModel.toJson())
        .toList();
        
    return sharedPreferences.setString(
      cachedPopularMoviesStr,
      json.encode(jsonList),
    );
  }
}
