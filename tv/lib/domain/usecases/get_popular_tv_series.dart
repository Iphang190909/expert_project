import 'package:dartz/dartz.dart';
import 'package:commons/commons.dart';
import 'package:tv/tv.dart';

class GetPopularTVSeries {
  final TVRepository repository;

  GetPopularTVSeries(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getPopularTV();
  }
}
