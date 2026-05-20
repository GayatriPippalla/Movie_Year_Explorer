import 'package:json_annotation/json_annotation.dart';

part 'movie_details_model.g.dart';

@JsonSerializable()
class MovieDetailsModel {

  @JsonKey(name: 'Title')
  final String title;

  @JsonKey(name: 'Year')
  final String year;

  @JsonKey(name: 'Poster')
  final String poster;

  @JsonKey(name: 'Plot')
  final String plot;

  @JsonKey(name: 'Genre')
  final String genre;

  @JsonKey(name: 'Director')
  final String director;

  @JsonKey(name: 'Actors')
  final String actors;

  @JsonKey(name: 'imdbRating')
  final String imdbRating;

  @JsonKey(name: 'Runtime')
  final String runtime;

  MovieDetailsModel({

    required this.title,

    required this.year,

    required this.poster,

    required this.plot,

    required this.genre,

    required this.director,

    required this.actors,

    required this.imdbRating,

    required this.runtime,
  });

  factory MovieDetailsModel.fromJson(
      Map<String, dynamic> json) =>
      _$MovieDetailsModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MovieDetailsModelToJson(this);
}