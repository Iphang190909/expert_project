import 'package:bloc_test/bloc_test.dart';
import 'package:commons/commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:dartz/dartz.dart';

import 'search_tv_bloc_test.mocks.dart';

final tTvModel = TV(
  backdropPath: '/path.jpg',
  genreIds: const [1],
  id: 1,
  name: 'name',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  voteAverage: 1.0,
  voteCount: 1,
);

final tTvList = <TV>[tTvModel];
const tQuery = 'Moon Knight';

@GenerateMocks([SearchTV])
void main() {
  late SearchTVBloc searchTvsBloc;
  late MockSearchTV mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTV();
    searchTvsBloc = SearchTVBloc(mockSearchTvs);
  });

  test('initial state should be empty', () {
    expect(searchTvsBloc.state, SearchTVEmpty());
  });

  blocTest<SearchTVBloc, SearchTVState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchTvsBloc;
    },
    act: (bloc) => bloc.add(const OnQuerySearch(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTVLoading(),
      SearchTVHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );

  blocTest<SearchTVBloc, SearchTVState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTvsBloc;
    },
    act: (bloc) => bloc.add(const OnQuerySearch(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTVLoading(),
      const SearchTVError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );
}
