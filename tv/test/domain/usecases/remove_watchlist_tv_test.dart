import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../../commons/test/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late RemoveWatchlistTVSeries removeWatchlistTVSeries;
  late MockTVRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTVRepository();
    removeWatchlistTVSeries = RemoveWatchlistTVSeries(mockTvRepository);
  });

  test('should remove watchlist Tv from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlist(tTVDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await removeWatchlistTVSeries.execute(tTVDetail);
    // assert
    verify(mockTvRepository.removeWatchlist(tTVDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
