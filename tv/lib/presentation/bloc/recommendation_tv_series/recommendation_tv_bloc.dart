import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:tv/tv.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTVBloc
    extends Bloc<RecommendationTVEvent, RecommendationTVState> {
  final GetRecommendationTVSeries _getRecommendationTVSeries;

  RecommendationTVBloc(this._getRecommendationTVSeries)
      : super(RecommendationTVEmpty()) {
    on<FetchRecommendationTV>((event, emit) async {
      emit(RecommendationTVLoading());

      final result = await _getRecommendationTVSeries.execute(event.id);

      result.fold((failure) {
        emit(RecommendationTVError(failure.message));
      }, (hasData) {
        emit(RecommendationTVHasData(hasData));
      });
    });
  }
}
