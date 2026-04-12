import 'package:flutter_test/flutter_test.dart';
import 'package:movie_explorer/data/models/omdb/omdb_movie_model.dart';
import 'package:movie_explorer/domain/entities/movie.dart';

void main() {
  group('OmdbMovieModel', () {
    const tModel = OmdbMovieModel(
      id: 'tt3896198',
      title: 'Guardians of the Galaxy Vol. 2',
      year: '2017',
      image: 'https://image.url/poster.jpg',
    );

    test('doit être une sous-classe de l\'entité Domain Movie', () {
      expect(tModel, isA<Movie>());
    });

    test('fromJson - doit extraire correctement les données du JSON d\'OMDB', () {
      // Simulate OMDB JSON response structure
      final Map<String, dynamic> jsonMap = {
        "Title": "Guardians of the Galaxy Vol. 2",
        "Year": "2017",
        "imdbID": "tt3896198",
        "Type": "movie",
        "Poster": "https://image.url/poster.jpg",
      };

      final result = OmdbMovieModel.fromJson(jsonMap);

      expect(result.id, equals('tt3896198'));
      expect(result.title, equals('Guardians of the Galaxy Vol. 2'));
      expect(result.year, equals('2017'));
      expect(result.image, equals('https://image.url/poster.jpg'));
      // Note: we hardcoded rating to 'N/A' inside the model because OMDB Search doesn't return it
      expect(result.rating, equals('N/A'));
    });
  });
}
