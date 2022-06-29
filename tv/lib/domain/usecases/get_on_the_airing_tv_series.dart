import 'package:commons/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetOnTheAirTVSeries {
  final TVRepository repository;

  GetOnTheAirTVSeries(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getOnTheAirTV();
  }
}
