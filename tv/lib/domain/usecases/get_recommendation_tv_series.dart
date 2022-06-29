import 'package:dartz/dartz.dart';
import 'package:commons/commons.dart';
import 'package:tv/tv.dart';

class GetRecommendationTVSeries {
  final TVRepository repository;

  GetRecommendationTVSeries(this.repository);

  Future<Either<Failure, List<TV>>> execute(id) {
    return repository.getRecommendationTV(id);
  }
}
