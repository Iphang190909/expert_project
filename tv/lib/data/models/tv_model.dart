import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

class TVModel extends Equatable {
  const TVModel(
      {required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.name,
      required this.originalName,
      required this.overview,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount,
      required this.popularity});

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String? posterPath;
  final double? voteAverage;
  final int voteCount;
  final double? popularity;

  factory TVModel.fromJson(Map<String, dynamic> json) => TVModel(
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
      id: json['id'],
      name: json['name'],
      originalName: json['original_name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      popularity: json['popularity'].toDouble());

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "name": name,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "popularity": popularity
      };

  TV toEntity() {
    return TV(
        backdropPath: backdropPath,
        genreIds: genreIds,
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
        originalName: originalName,
        voteAverage: voteAverage,
        voteCount: voteCount,
        popularity: popularity);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        name,
        originalName,
        overview,
        posterPath,
        voteAverage,
        voteCount,
        popularity
      ];
}
