import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:tv/tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTVBloc extends Bloc<TopRatedTVEvent, TopRatedTVState> {
  final GetTopTVSeries _getTopTVSeries;

  TopRatedTVBloc(this._getTopTVSeries) : super(TopRatedTVEmpty()) {
    on<FetchTopRatedTV>((event, emit) async {
      emit(TopRatedTVLoading());

      final result = await _getTopTVSeries.execute();

      result.fold((failure) {
        emit(TopRatedTVError(failure.message));
      }, (hasData) {
        emit(TopRatedTVHasData(hasData));
      });
    });
  }
}
