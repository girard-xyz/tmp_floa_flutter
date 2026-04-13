import 'package:sqflite/sqflite.dart';
import 'package:movie_explorer/domain/entities/movie.dart';
import 'package:movie_explorer/data/models/local/local_movie_model.dart';
import 'package:movie_explorer/data/datasources/movie_local_data_source.dart';

class SqfliteLocalDataSourceImpl implements MovieLocalDataSource {
  final Database database;

  SqfliteLocalDataSourceImpl({required this.database});

  // --- Favoris ---
  @override
  Future<List<Movie>> getFavorites() async {
    final List<Map<String, dynamic>> maps = await database.query(
      'favorite_movies',
    );
    return maps.map((map) => LocalMovieModel.fromMap(map)).toList();
  }

  @override
  Future<void> saveFavorite(Movie movie) async {
    await database.insert(
      'favorite_movies',
      LocalMovieModel.fromEntity(movie).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavorite(String movieId) async {
    await database.delete(
      'favorite_movies',
      where: 'id = ?',
      whereArgs: [movieId],
    );
  }
}
