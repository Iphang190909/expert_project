part of 'detail_tv_bloc.dart';

@immutable
abstract class DetailTVEvent extends Equatable {
  const DetailTVEvent();

  @override
  List<Object?> get props => [];
}

class FetchDetailTV extends DetailTVEvent {
  final int id;

  const FetchDetailTV(this.id);

  @override
  List<Object?> get props => [id];
}
