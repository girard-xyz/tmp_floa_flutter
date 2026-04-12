import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String id;
  final String title;
  final String year;
  final String image;
  final String rating;
  final String? overview;
  final int? runtime;
  final String? backdrop;
  final List<String>? genres;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.image,
    required this.rating,
    this.overview,
    this.runtime,
    this.backdrop,
    this.genres,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    year,
    image,
    rating,
    overview,
    runtime,
    backdrop,
    genres,
  ];
}
