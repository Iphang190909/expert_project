part of 'top_rated_tv_bloc.dart';

@immutable
abstract class TopRatedTVState extends Equatable {
  const TopRatedTVState();

  @override
  List<Object?> get props => [];
}

class TopRatedTVEmpty extends TopRatedTVState {}

class TopRatedTVLoading extends TopRatedTVState {}

class TopRatedTVHasData extends TopRatedTVState {
  final List<TV> result;

  const TopRatedTVHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TopRatedTVError extends TopRatedTVState {
  final String message;

  const TopRatedTVError(this.message);

  @override
  List<Object?> get props => [message];
}
