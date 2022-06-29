import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:tv/tv.dart';

part 'on_the_air_tv_state.dart';
part 'on_the_air_tv_event.dart';

class OnTheAirTVBloc extends Bloc<OnTheAirTVEvent, OnTheAirTVState> {
  final GetOnTheAirTVSeries _getOnTheAirTVSeries;

  OnTheAirTVBloc(this._getOnTheAirTVSeries) : super(OnTheAirTVEmpty()) {
    on<FetchOnTheAirTV>((event, emit) async {
      emit(OnTheAirTVLoading());

      final result = await _getOnTheAirTVSeries.execute();

      result.fold((failure) {
        emit(OnTheAirTVError(failure.message));
      }, (data) {
        emit(OnTheAirTVHasData(data));
      });
    });
  }
}
