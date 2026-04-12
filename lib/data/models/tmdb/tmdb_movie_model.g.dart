// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbMovieModel _$TmdbMovieModelFromJson(Map<String, dynamic> json) =>
    TmdbMovieModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      releaseDate: json['release_date'] as String?,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      overview: json['overview'] as String?,
      runtime: (json['runtime'] as num?)?.toInt(),
      backdropPath: json['backdrop_path'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$TmdbMovieModelToJson(TmdbMovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'release_date': instance.releaseDate,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'overview': instance.overview,
      'runtime': instance.runtime,
      'backdrop_path': instance.backdropPath,
      'genres': instance.genres,
    };

TmdbResponse _$TmdbResponseFromJson(Map<String, dynamic> json) => TmdbResponse(
  results: (json['results'] as List<dynamic>)
      .map((e) => TmdbMovieModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TmdbResponseToJson(TmdbResponse instance) =>
    <String, dynamic>{'results': instance.results};
