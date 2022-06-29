import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../../../commons/test/helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTVSeries usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetPopularTVSeries(mockTVRepository);
  });

  test('Should get list popular TV from the repository', () async {
    // arrange
    when(mockTVRepository.getPopularTV())
        .thenAnswer((_) async => Right(tTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvList));
  });
}
