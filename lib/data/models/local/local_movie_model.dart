import 'package:movie_explorer/domain/entities/movie.dart';

class LocalMovieModel extends Movie {
  const LocalMovieModel({
    required super.id,
    required super.title,
    required super.year,
    required super.image,
    required super.rating,
  });

  factory LocalMovieModel.fromEntity(Movie movie) {
    return LocalMovieModel(
      id: movie.id,
      title: movie.title,
      year: movie.year,
      image: movie.image,
      rating: movie.rating,
    );
  }

  factory LocalMovieModel.fromMap(Map<String, dynamic> map) {
    return LocalMovieModel(
      id: map['id'] as String,
      title: map['title'] as String,
      year: map['year'] as String,
      image: map['image'] as String,
      rating: map['rating'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'image': image,
      'rating': rating,
    };
  }
}
