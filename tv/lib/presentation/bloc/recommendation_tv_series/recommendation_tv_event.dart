part of 'recommendation_tv_bloc.dart';

@immutable
abstract class RecommendationTVEvent extends Equatable {
  const RecommendationTVEvent();

  @override
  List<Object?> get props => [];
}

class FetchRecommendationTV extends RecommendationTVEvent {
  final int id;

  const FetchRecommendationTV(this.id);

  @override
  List<Object?> get props => [id];
}
