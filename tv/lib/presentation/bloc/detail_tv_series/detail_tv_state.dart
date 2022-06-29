part of 'detail_tv_bloc.dart';

@immutable
abstract class DetailTVState extends Equatable {
  const DetailTVState();

  @override
  List<Object?> get props => [];
}

class DetailTVEmpty extends DetailTVState {}

class DetailTVLoading extends DetailTVState {}

class DetailTVHasData extends DetailTVState {
  final TvDetail result;

  const DetailTVHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class DetailTVError extends DetailTVState {
  final String message;

  const DetailTVError(this.message);

  @override
  List<Object?> get props => [message];
}
