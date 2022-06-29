import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../commons/test/helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirTVSeries usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetOnTheAirTVSeries(mockTVRepository);
  });

  final tListTv = <TV>[];

  test('Should get list on the air TV from the repository', () async {
    // arrange
    when(mockTVRepository.getOnTheAirTV())
        .thenAnswer((_) async => Right(tListTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tListTv));
  });
}
