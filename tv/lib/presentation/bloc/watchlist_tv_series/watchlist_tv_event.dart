part of 'watchlist_tv_bloc.dart';

@immutable
abstract class WatchlistTVEvent extends Equatable {
  const WatchlistTVEvent();

  @override
  List<Object?> get props => [];
}

class FetchWatchlistTV extends WatchlistTVEvent {}

class AddWatchlistTV extends WatchlistTVEvent {
  final TvDetail tvDetail;

  const AddWatchlistTV(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class RemoveWatchlistTV extends WatchlistTVEvent {
  final TvDetail tvDetail;

  const RemoveWatchlistTV(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class LoadWatchlistStatusTV extends WatchlistTVEvent {
  final int id;

  const LoadWatchlistStatusTV(this.id);

  @override
  List<Object?> get props => [id];
}
