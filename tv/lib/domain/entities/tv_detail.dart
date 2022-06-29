import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

class TvDetail extends Equatable {
  final String backdropPath;
  final int id;
  final List<GenreTv> genres;
  final String name;
  final String originalName;
  final String overview;
  final String? posterPath;
  final String firstAirDate;
  final double voteAvarage;
  final int voteCount;
  final double popularity;

  TvDetail(
      {required this.backdropPath,
      required this.id,
      required this.genres,
      required this.originalName,
      required this.overview,
      required this.posterPath,
      required this.firstAirDate,
      required this.voteAvarage,
      required this.voteCount,
      required this.name,
      required this.popularity});

  @override
  List<Object?> get props => [
        id,
        genres,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        voteAvarage,
        voteCount,
        name,
        popularity,
        backdropPath
      ];
}
