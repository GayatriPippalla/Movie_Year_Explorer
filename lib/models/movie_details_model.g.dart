// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsModel _$MovieDetailsModelFromJson(Map<String, dynamic> json) =>
    MovieDetailsModel(
      title: json['Title'] as String,
      year: json['Year'] as String,
      poster: json['Poster'] as String,
      plot: json['Plot'] as String,
      genre: json['Genre'] as String,
      director: json['Director'] as String,
      actors: json['Actors'] as String,
      imdbRating: json['imdbRating'] as String,
      runtime: json['Runtime'] as String,
    );

Map<String, dynamic> _$MovieDetailsModelToJson(MovieDetailsModel instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'Poster': instance.poster,
      'Plot': instance.plot,
      'Genre': instance.genre,
      'Director': instance.director,
      'Actors': instance.actors,
      'imdbRating': instance.imdbRating,
      'Runtime': instance.runtime,
    };
