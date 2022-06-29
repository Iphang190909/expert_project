import 'package:bloc_test/bloc_test.dart';
import 'package:commons/commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_the_air_tv_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTVSeries])
void main() {
  late OnTheAirTVBloc onTheAirTvsBloc;
  late MockGetOnTheAirTVSeries mockGetOnTheAirTvs;

  setUp(() {
    mockGetOnTheAirTvs = MockGetOnTheAirTVSeries();
    onTheAirTvsBloc = OnTheAirTVBloc(mockGetOnTheAirTvs);
  });

  test('initial state should be empty', () {
    expect(onTheAirTvsBloc.state, OnTheAirTVEmpty());
  });

  blocTest<OnTheAirTVBloc, OnTheAirTVState>(
    'Should emit [OnTheAirTvsLoading, OnTheAirTvsHasData] when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return onTheAirTvsBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTV()),
    expect: () => [
      OnTheAirTVLoading(),
      OnTheAirTVHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTvs.execute());
    },
  );

  blocTest<OnTheAirTVBloc, OnTheAirTVState>(
    'Should emit [OnTheAirTvsLoading, OnTheAirTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetOnTheAirTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return onTheAirTvsBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTV()),
    expect: () => [
      OnTheAirTVLoading(),
      const OnTheAirTVError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTvs.execute());
    },
  );
}
