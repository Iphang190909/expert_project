import 'package:bloc_test/bloc_test.dart';
import 'package:commons/commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late PopularTVBloc popularTvsBloc;
  late MockGetPopularTVSeries mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTVSeries();
    popularTvsBloc = PopularTVBloc(mockGetPopularTvs);
  });

  test('initial state should be empty', () {
    expect(popularTvsBloc.state, PopularTVEmpty());
  });

  blocTest<PopularTVBloc, PopularTVState>(
    'Should emit [PopularTvsLoading, PopularTvsHasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));
      return popularTvsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTV()),
    expect: () => [
      PopularTVLoading(),
      PopularTVHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );

  blocTest<PopularTVBloc, PopularTVState>(
    'Should emit [PopularTvsLoading, PopularTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTvsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTV()),
    expect: () => [
      PopularTVLoading(),
      const PopularTVError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );
}
