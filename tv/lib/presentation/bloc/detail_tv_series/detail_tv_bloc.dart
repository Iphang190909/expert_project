import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTVBloc extends Bloc<DetailTVEvent, DetailTVState> {
  final GetTvDetailSeries _getTvDetailSeries;

  DetailTVBloc(this._getTvDetailSeries) : super(DetailTVEmpty()) {
    on<FetchDetailTV>((event, emit) async {
      emit(DetailTVLoading());

      final result = await _getTvDetailSeries.execute(event.id);

      result.fold((failure) {
        emit(DetailTVError(failure.message));
      }, (hasData) {
        emit(DetailTVHasData(hasData));
      });
    });
  }
}
