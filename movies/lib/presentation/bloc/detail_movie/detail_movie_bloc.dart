import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getMovieDetail;

  DetailMovieBloc(this._getMovieDetail) : super(DetailMovieEmpty()) {
    on<FetchDetailMovie>((event, emit) async {
      final id = event.id;

      emit(DetailMovieLoading());

      final result = await _getMovieDetail.execute(id);

      result.fold((failure) {
        emit(DetailMovieError(failure.message));
      }, (hasData) {
        emit(DetailMovieHasData(hasData));
      });
    });
  }
}
