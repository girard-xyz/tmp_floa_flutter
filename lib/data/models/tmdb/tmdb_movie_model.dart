import 'package:json_annotation/json_annotation.dart';
import 'package:movie_explorer/domain/entities/movie.dart';

part 'tmdb_movie_model.g.dart';

@JsonSerializable()
class TmdbMovieModel {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'runtime')
  final int? runtime;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genres')
  final List<Map<String, dynamic>>? genres;

  TmdbMovieModel({
    required this.id,
    required this.title,
    this.releaseDate,
    this.posterPath,
    this.voteAverage,
    this.overview,
    this.runtime,
    this.backdropPath,
    this.genres,
  });

  factory TmdbMovieModel.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$TmdbMovieModelToJson(this);

  /// Découple totalement la couche Data de la couche Domain
  /// en la mappant explicitement après réception.
  Movie toEntity() {
    return Movie(
      id: id.toString(),
      title: title,
      year: releaseDate != null && releaseDate!.length >= 4
          ? releaseDate!.substring(0, 4)
          : 'N/A',
      image: posterPath != null
          ? 'https://image.tmdb.org/t/p/w500$posterPath'
          : '',
      rating: voteAverage?.toStringAsFixed(1) ?? 'N/A',
      overview: overview,
      runtime: runtime,
      backdrop: backdropPath != null
          ? 'https://image.tmdb.org/t/p/w1280$backdropPath'
          : null,
      genres: genres?.map((g) => g['name'] as String).toList(),
    );
  }
}

@JsonSerializable()
class TmdbResponse {
  final List<TmdbMovieModel> results;

  TmdbResponse({required this.results});

  factory TmdbResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TmdbResponseToJson(this);
}
