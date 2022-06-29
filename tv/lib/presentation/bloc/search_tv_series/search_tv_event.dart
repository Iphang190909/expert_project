part of 'search_tv_bloc.dart';

@immutable
abstract class SearchTVEvent extends Equatable {
  const SearchTVEvent();

  @override
  List<Object?> get props => [];
}

class OnQuerySearch extends SearchTVEvent {
  final String query;

  const OnQuerySearch(this.query);

  @override
  List<Object?> get props => [query];
}
