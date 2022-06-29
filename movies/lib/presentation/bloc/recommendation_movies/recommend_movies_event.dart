part of 'recommend_movies_bloc.dart';

@immutable
abstract class RecommendMoviesEvent extends Equatable {
  const RecommendMoviesEvent();

  @override
  List<Object?> get props => [];
}

class FetchRecommendMovies extends RecommendMoviesEvent {
  final int id;

  const FetchRecommendMovies(this.id);

  @override
  List<Object?> get props => [id];
}
