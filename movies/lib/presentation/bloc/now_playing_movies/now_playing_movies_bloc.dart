import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movie_state.dart';
part 'now_playing_movie_event.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMovieBloc(this._getNowPlayingMovies)
      : super(NowPlayingMoviesEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMovieLoading());

      final result = await _getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(NowPlayingMoviesError(failure.message));
      }, (hasData) {
        emit(NowPlayingMoviesHasData(hasData));
      });
    });
  }
}
