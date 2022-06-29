import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:tv/tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTVBloc extends Bloc<WatchlistTVEvent, WatchlistTVState> {
  final GetTVWatchList _getTVWatchList;
  final SaveTVWatchlist _saveTVWatchlist;
  final RemoveWatchlistTVSeries _removeWatchlistTVSeries;
  final GetWatchListTVStatus _getWatchListTVStatus;

  WatchlistTVBloc(this._getTVWatchList, this._saveTVWatchlist,
      this._removeWatchlistTVSeries, this._getWatchListTVStatus)
      : super(WatchlistTVEmpty()) {
    on<FetchWatchlistTV>((event, emit) async {
      emit(WatchlistTVLoading());

      final result = await _getTVWatchList.execute();

      result.fold((failure) {
        emit(WatchlistTVError(failure.message));
      }, (hasData) {
        emit(WatchlistTVHasData(hasData));
      });
    });

    on<AddWatchlistTV>((event, emit) async {
      final tvDetail = event.tvDetail;

      final result = await _saveTVWatchlist.execute(tvDetail);

      result.fold((failure) {
        emit(WatchlistTVError(failure.message));
      }, (message) {
        emit(const WatchlistTVSuccess("Added To Watchlist"));
      });

      add(LoadWatchlistStatusTV(tvDetail.id));
    });

    on<RemoveWatchlistTV>((event, emit) async {
      final tvDetail = event.tvDetail;

      final result = await _removeWatchlistTVSeries.execute(tvDetail);

      result.fold((failure) {
        emit(WatchlistTVError(failure.message));
      }, (message) {
        emit(const WatchlistTVSuccess("Removed From Watchlist"));
      });

      add(LoadWatchlistStatusTV(tvDetail.id));
    });

    on<LoadWatchlistStatusTV>((event, emit) async {
      final id = event.id;
      final result = await _getWatchListTVStatus.execute(id);

      emit(WatchlistTVStatus(result));
    });
  }
}
