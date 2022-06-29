import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTVBloc extends Bloc<PopularTVEvent, PopularTVState> {
  final GetPopularTVSeries _getPopularTVSeries;

  PopularTVBloc(this._getPopularTVSeries) : super(PopularTVEmpty()) {
    on<FetchPopularTV>((event, emit) async {
      emit(PopularTVLoading());

      final result = await _getPopularTVSeries.execute();

      result.fold((failure) {
        emit(PopularTVError(failure.message));
      }, (hasData) {
        emit(PopularTVHasData(hasData));
      });
    });
  }
}
