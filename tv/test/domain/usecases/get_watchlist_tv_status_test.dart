import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../../commons/test/helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListTVStatus getWatchListTVStatus;
  late MockTVRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTVRepository();
    getWatchListTVStatus = GetWatchListTVStatus(mockTvRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToWatchlist(1)).thenAnswer((_) async => true);
    // act
    final result = await getWatchListTVStatus.execute(1);
    // assert
    expect(result, true);
  });
}
