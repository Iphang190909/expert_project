part of 'popular_tv_bloc.dart';

@immutable
abstract class PopularTVState extends Equatable {
  const PopularTVState();

  @override
  List<Object?> get props => [];
}

class PopularTVEmpty extends PopularTVState {}

class PopularTVLoading extends PopularTVState {}

class PopularTVHasData extends PopularTVState {
  final List<TV> result;

  const PopularTVHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class PopularTVError extends PopularTVState {
  final String message;

  const PopularTVError(this.message);

  @override
  List<Object?> get props => [message];
}
