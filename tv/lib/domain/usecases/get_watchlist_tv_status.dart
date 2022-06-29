import 'package:tv/tv.dart';

class GetWatchListTVStatus {
  final TVRepository repository;

  GetWatchListTVStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
