import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'recommend_movie_state.dart';
part 'recommend_movies_event.dart';

class RecommendMoviesBloc
    extends Bloc<RecommendMoviesEvent, RecommendMoviesState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendMoviesBloc(this._getMovieRecommendations)
      : super(RecommendMoviesEmpty()) {
    on<FetchRecommendMovies>((event, emit) async {
      final id = event.id;

      emit(RecommendMoviesLoading());

      final result = await _getMovieRecommendations.execute(id);

      result.fold((failure) {
        emit(RecommendMoviesError(failure.message));
      }, (hasData) {
        emit(RecommendMoviesHasData(hasData));
      });
    });
  }
}
