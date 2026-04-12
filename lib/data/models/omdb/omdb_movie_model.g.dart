// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omdb_movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OmdbMovieModel _$OmdbMovieModelFromJson(Map<String, dynamic> json) =>
    OmdbMovieModel(
      id: json['imdbID'] as String,
      title: json['Title'] as String,
      year: json['Year'] as String,
      image: json['Poster'] as String,
    );

Map<String, dynamic> _$OmdbMovieModelToJson(OmdbMovieModel instance) =>
    <String, dynamic>{
      'imdbID': instance.id,
      'Title': instance.title,
      'Year': instance.year,
      'Poster': instance.image,
    };

OmdbResponse _$OmdbResponseFromJson(Map<String, dynamic> json) => OmdbResponse(
  search: (json['Search'] as List<dynamic>?)
      ?.map((e) => OmdbMovieModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OmdbResponseToJson(OmdbResponse instance) =>
    <String, dynamic>{'Search': instance.search};
