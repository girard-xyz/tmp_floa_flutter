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

  TmdbMovieModel({
    required this.id,
    required this.title,
    this.releaseDate,
    this.posterPath,
    this.voteAverage,
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
