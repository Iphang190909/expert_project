import 'package:equatable/equatable.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/tv.dart';

class TVDetailModel extends Equatable {
  const TVDetailModel(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genres,
      required this.id,
      required this.name,
      required this.originalName,
      required this.posterPath,
      required this.voteAvarage,
      required this.voteCount,
      required this.overview,
      required this.popularity});

  final String backdropPath;
  final List<GenreTVModel> genres;
  final int id;
  final String name;
  final String originalName;
  final String? posterPath;
  final String firstAirDate;
  final double voteAvarage;
  final int voteCount;
  final String overview;
  final double popularity;

  factory TVDetailModel.fromJson(Map<String, dynamic> json) => TVDetailModel(
      backdropPath: json['backdrop_path'] as String,
      firstAirDate: json['first_air_date'],
      genres: List<GenreTVModel>.from(
          json['genres'].map((x) => GenreTVModel.fromJson(x))),
      id: json['id'],
      name: json['name'],
      originalName: json['original_name'],
      posterPath: json['poster_path'],
      voteAvarage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble());

  Map<String, dynamic> toJson() => {
        'backdrop_path': backdropPath,
        'first_air_date': firstAirDate,
        'genres': List<dynamic>.from(genres.map((e) => e.toJson())),
        'id': id,
        'name': name,
        'original_name': originalName,
        'poster_path': posterPath,
        'vote_avarage': voteAvarage,
        'vote_count': voteCount,
        'overview': overview,
        'popularity': popularity
      };

  TvDetail toEntity() => TvDetail(
      backdropPath: backdropPath,
      id: id,
      genres: genres.map((e) => e.toEntity()).toList(),
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      firstAirDate: firstAirDate,
      voteAvarage: voteAvarage,
      voteCount: voteCount,
      name: name,
      popularity: popularity);

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        name,
        originalName,
        posterPath,
        firstAirDate,
        voteAvarage,
        voteCount,
        overview
      ];
}
