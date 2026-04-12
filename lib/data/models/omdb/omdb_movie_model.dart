import 'package:json_annotation/json_annotation.dart';
import 'package:movie_explorer/domain/entities/movie.dart';

part 'omdb_movie_model.g.dart';

@JsonSerializable()
class OmdbMovieModel extends Movie {
  const OmdbMovieModel({
    @JsonKey(name: 'imdbID') required super.id,
    @JsonKey(name: 'Title') required super.title,
    @JsonKey(name: 'Year') required super.year,
    @JsonKey(name: 'Poster') required super.image,
  }) : super(rating: 'N/A');

  factory OmdbMovieModel.fromJson(Map<String, dynamic> json) =>
      _$OmdbMovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$OmdbMovieModelToJson(this);
}

@JsonSerializable()
class OmdbResponse {
  @JsonKey(name: 'Search')
  final List<OmdbMovieModel>? search;

  OmdbResponse({this.search});

  factory OmdbResponse.fromJson(Map<String, dynamic> json) =>
      _$OmdbResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OmdbResponseToJson(this);
}
