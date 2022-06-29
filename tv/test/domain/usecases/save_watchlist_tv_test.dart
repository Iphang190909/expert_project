import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../../commons/test/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late SaveTVWatchlist saveTVWatchlist;
  late MockTVRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTVRepository();
    saveTVWatchlist = SaveTVWatchlist(mockTvRepository);
  });

  test('should save Tv to the repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlist(tTVDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await saveTVWatchlist.execute(tTVDetail);
    // assert
    verify(mockTvRepository.saveWatchlist(tTVDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
