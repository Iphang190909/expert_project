import 'package:dartz/dartz.dart';
import 'package:commons/commons.dart';
import 'package:tv/tv.dart';

class SearchTV {
  final TVRepository repository;

  SearchTV(this.repository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchTV(query);
  }
}
