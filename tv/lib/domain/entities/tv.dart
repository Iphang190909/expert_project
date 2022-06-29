import 'package:equatable/equatable.dart';

class TV extends Equatable {
  TV(
      {required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.overview,
      required this.posterPath,
      required this.name,
      required this.originalName,
      required this.voteAverage,
      required this.voteCount,
      required this.popularity});

  TV.whatchlist(
      {required this.id,
      required this.overview,
      required this.posterPath,
      required this.name});

  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? name;
  String? overview;
  String? posterPath;
  String? originalName;
  double? voteAverage;
  int? voteCount;
  double? popularity;

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        overview,
        posterPath,
        name,
        originalName,
        voteAverage,
        voteCount,
        popularity
      ];
}
