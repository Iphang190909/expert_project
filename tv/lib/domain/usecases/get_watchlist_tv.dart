import 'package:dartz/dartz.dart';
import 'package:commons/commons.dart';
import 'package:tv/tv.dart';

class GetTVWatchList {
  final TVRepository _repository;

  GetTVWatchList(this._repository);

  Future<Either<Failure, List<TV>>> execute() {
    return _repository.getWatchlistTV();
  }
}
