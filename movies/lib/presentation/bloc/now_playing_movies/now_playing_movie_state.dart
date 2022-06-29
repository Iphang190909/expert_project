part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object?> get props => [];
}

class NowPlayingMoviesEmpty extends NowPlayingMovieState {}

class NowPlayingMovieLoading extends NowPlayingMovieState {}

class NowPlayingMoviesHasData extends NowPlayingMovieState {
  final List<Movie> result;

  const NowPlayingMoviesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class NowPlayingMoviesError extends NowPlayingMovieState {
  final String message;

  const NowPlayingMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
