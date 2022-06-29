import 'package:bloc_test/bloc_test.dart';
import 'package:commons/commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVWatchList,
  SaveTVWatchlist,
  RemoveWatchlistTVSeries,
  GetWatchListTVStatus
])
void main() {
  late WatchlistTVBloc watchlistTvsBloc;
  late MockGetTVWatchList mockGetWatchlistTvs;
  late MockSaveTVWatchlist mockSaveWatchlist;
  late MockRemoveWatchlistTVSeries mockRemoveWatchlist;
  late MockGetWatchListTVStatus mockGetWatchListStatus;

  setUp(() {
    mockGetWatchlistTvs = MockGetTVWatchList();
    mockSaveWatchlist = MockSaveTVWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlistTVSeries();
    mockGetWatchListStatus = MockGetWatchListTVStatus();
    watchlistTvsBloc = WatchlistTVBloc(
      mockGetWatchlistTvs,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchListStatus,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistTvsBloc.state, WatchlistTVEmpty());
  });

  blocTest<WatchlistTVBloc, WatchlistTVState>(
    'Should emit [WatchlistTvsLoading, WatchlistTvsHasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return watchlistTvsBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTV()),
    expect: () => [
      WatchlistTVLoading(),
      WatchlistTVHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );

  blocTest<WatchlistTVBloc, WatchlistTVState>(
    'Should emit [WatchlistTvsLoading, WatchlistTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistTvsBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTV()),
    expect: () => [
      WatchlistTVLoading(),
      const WatchlistTVError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );
}
