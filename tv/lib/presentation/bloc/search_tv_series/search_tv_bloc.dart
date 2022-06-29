import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:tv/tv.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTVBloc extends Bloc<SearchTVEvent, SearchTVState> {
  final SearchTV _searchTV;

  SearchTVBloc(this._searchTV) : super(SearchTVEmpty()) {
    on<OnQuerySearch>((event, emit) async {
      final query = event.query;

      emit(SearchTVLoading());

      final result = await _searchTV.execute(query);

      result.fold((failure) {
        emit(SearchTVError(failure.message));
      }, (hasData) {
        emit(SearchTVHasData(hasData));
      });
    }, transformer: debounce(const Duration(microseconds: 400)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
  }
}
