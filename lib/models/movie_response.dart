import 'package:json_annotation/json_annotation.dart';

import 'movie_model.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {

  @JsonKey(name: 'Search')
  final List<MovieModel>? movies;

  @JsonKey(name: 'Response')
  final String response;

  @JsonKey(name: 'Error')
  final String? error;

  MovieResponse({

    this.movies,

    required this.response,

    this.error,
  });

  factory MovieResponse.fromJson(
      Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MovieResponseToJson(this);
}