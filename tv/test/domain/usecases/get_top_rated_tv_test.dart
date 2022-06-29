import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../../../commons/test/helpers/test_helper.mocks.dart';

void main() {
  late GetTopTVSeries usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTopTVSeries(mockTVRepository);
  });

  test('Should get list TV top rated from the repository', () async {
    // arrange
    when(mockTVRepository.getTopRatedTV())
        .thenAnswer((_) async => Right(tTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvList));
  });
}
