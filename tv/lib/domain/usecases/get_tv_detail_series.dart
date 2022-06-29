import 'package:dartz/dartz.dart';
import 'package:commons/commons.dart';
import 'package:tv/tv.dart';

class GetTvDetailSeries {
  final TVRepository repository;

  GetTvDetailSeries(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTVDetail(id);
  }
}
