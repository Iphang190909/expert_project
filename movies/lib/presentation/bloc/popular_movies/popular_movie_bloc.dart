import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'popular_movie_state.dart';
part 'popular_movie_event.dart';

class PopularMoviesBloc extends Bloc<PopularMovieEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(PopularMoviesEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());
      final result = await _getPopularMovies.execute();

      result.fold((failure) {
        emit(PopularMoviesError(failure.message));
      }, (hasData) {
        emit(PopularMoviesHasData(hasData));
      });
    });
  }
}
