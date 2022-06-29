import 'package:bloc_test/bloc_test.dart';
import 'package:commons/commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopTVSeries])
void main() {
  late TopRatedTVBloc topRatedTVBloc;
  late MockGetTopTVSeries mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopTVSeries();
    topRatedTVBloc = TopRatedTVBloc(mockGetTopRatedTvs);
  });

  test('initial state should be empty', () {
    expect(topRatedTVBloc.state, TopRatedTVEmpty());
  });

  blocTest<TopRatedTVBloc, TopRatedTVState>(
    'Should emit [TopRatedTvsLoading, TopRatedTvsHasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return topRatedTVBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTV()),
    expect: () => [
      TopRatedTVLoading(),
      TopRatedTVHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );

  blocTest<TopRatedTVBloc, TopRatedTVState>(
    'Should emit [TopRatedTvsLoading, TopRatedTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTVBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTV()),
    expect: () => [
      TopRatedTVLoading(),
      const TopRatedTVError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );
}
