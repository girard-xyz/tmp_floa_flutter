import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/movie.dart';

part 'omdb_movie_model.g.dart';

@JsonSerializable()
class OmdbMovieModel extends Movie {
  const OmdbMovieModel({
    @JsonKey(name: 'imdbID') required String id,
    @JsonKey(name: 'Title') required String title,
    @JsonKey(name: 'Year') required String year,
    @JsonKey(name: 'Poster') required String image,
  }) : super(id: id, title: title, year: year, image: image, rating: 'N/A');

  factory OmdbMovieModel.fromJson(Map<String, dynamic> json) => _$OmdbMovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$OmdbMovieModelToJson(this);
}

@JsonSerializable()
class OmdbResponse {
  @JsonKey(name: 'Search')
  final List<OmdbMovieModel>? search;

  OmdbResponse({this.search});

  factory OmdbResponse.fromJson(Map<String, dynamic> json) => _$OmdbResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OmdbResponseToJson(this);
}
