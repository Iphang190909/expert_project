part of 'popular_tv_bloc.dart';

@immutable
abstract class PopularTVEvent extends Equatable {
  const PopularTVEvent();

  @override
  List<Object?> get props => [];
}

class FetchPopularTV extends PopularTVEvent {}
