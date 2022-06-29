import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../../commons/test/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late GetTVWatchList getTVWatchList;
  late MockTVRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTVRepository();
    getTVWatchList = GetTVWatchList(mockTvRepository);
  });

  test('should get list of Tvs from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTV())
        .thenAnswer((_) async => Right(tTvList));
    // act
    final result = await getTVWatchList.execute();
    // assert
    expect(result, Right(tTvList));
  });
}
