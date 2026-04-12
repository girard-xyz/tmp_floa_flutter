import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String id;
  final String title;
  final String year;
  final String image;
  final String rating;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.image,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, title, year, image, rating];
}
