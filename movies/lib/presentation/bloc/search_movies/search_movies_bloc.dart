import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMovieBloc extends Bloc<SearchMoviesEvent, SearchMovieState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(SearchMovieEmpty()) {
    on<OnQuerySearch>((event, emit) async {
      final query = event.query;

      emit(SearchMovieLoading());

      final result = await _searchMovies.execute(query);

      result.fold((failure) {
        emit(SearchMovieError(failure.message));
      }, (hasData) {
        emit(SearchMovieHasData(hasData));
      });
    });
  }
}
