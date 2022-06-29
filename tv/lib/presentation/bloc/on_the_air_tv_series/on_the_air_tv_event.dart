part of 'on_the_air_tv_bloc.dart';

@immutable
abstract class OnTheAirTVEvent extends Equatable {
  const OnTheAirTVEvent();

  @override
  List<Object?> get props => [];
}

class FetchOnTheAirTV extends OnTheAirTVEvent {}
