part of 'recommendation_tv_bloc.dart';

@immutable
abstract class RecommendationTVState extends Equatable {
  const RecommendationTVState();

  @override
  List<Object?> get props => [];
}

class RecommendationTVEmpty extends RecommendationTVState {}

class RecommendationTVLoading extends RecommendationTVState {}

class RecommendationTVHasData extends RecommendationTVState {
  final List<TV> result;

  const RecommendationTVHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class RecommendationTVError extends RecommendationTVState {
  final String message;

  const RecommendationTVError(this.message);

  @override
  List<Object?> get props => [message];
}
