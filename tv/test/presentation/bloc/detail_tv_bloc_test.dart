import 'package:bloc_test/bloc_test.dart';
import 'package:commons/commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetailSeries])
void main() {
  late DetailTVBloc detailTvBloc;
  late MockGetTvDetailSeries mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetailSeries();
    detailTvBloc = DetailTVBloc(mockGetTvDetail);
  });

  const int id = 1;

  test('initial state should be empty', () {
    expect(detailTvBloc.state, DetailTVEmpty());
  });

  blocTest<DetailTVBloc, DetailTVState>(
    'Should emit [DetailTvLoading, DetailTvHasData] when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(id))
          .thenAnswer((_) async => Right(tTVDetail));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailTV(id)),
    expect: () => [
      DetailTVLoading(),
      DetailTVHasData(tTVDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
    },
  );

  blocTest<DetailTVBloc, DetailTVState>(
    'Should emit [DetailTvLoading, DetailTvError] when get data is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(id))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailTV(id)),
    expect: () => [
      DetailTVLoading(),
      const DetailTVError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
    },
  );
}
