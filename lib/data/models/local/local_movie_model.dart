import '../../../domain/entities/movie.dart';

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

  factory LocalMovieModel.fromJson(Map<String, dynamic> json) {
    return LocalMovieModel(
      id: json['id'] as String,
      title: json['title'] as String,
      year: json['year'] as String,
      image: json['image'] as String,
      rating: json['rating'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'image': image,
      'rating': rating,
    };
  }
}
