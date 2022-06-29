part of 'watchlist_tv_bloc.dart';

@immutable
class WatchlistTVState extends Equatable {
  const WatchlistTVState();

  @override
  List<Object?> get props => [];
}

class WatchlistTVEmpty extends WatchlistTVState {}

class WatchlistTVLoading extends WatchlistTVState {}

class WatchlistTVHasData extends WatchlistTVState {
  final List<TV> result;

  const WatchlistTVHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class WatchlistTVError extends WatchlistTVState {
  final String message;

  const WatchlistTVError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistTVSuccess extends WatchlistTVState {
  final String message;

  const WatchlistTVSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVFailure extends WatchlistTVState {
  final String message;

  const WatchlistTVFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVStatus extends WatchlistTVState {
  final bool isAddedToWatchlist;

  const WatchlistTVStatus(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
