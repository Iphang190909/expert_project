part of 'recommend_movies_bloc.dart';

@immutable
abstract class RecommendMoviesState extends Equatable {
  const RecommendMoviesState();

  @override
  List<Object?> get props => [];
}

class RecommendMoviesEmpty extends RecommendMoviesState {}

class RecommendMoviesLoading extends RecommendMoviesState {}

class RecommendMoviesHasData extends RecommendMoviesState {
  final List<Movie> result;

  const RecommendMoviesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class RecommendMoviesError extends RecommendMoviesState {
  final String message;

  const RecommendMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
