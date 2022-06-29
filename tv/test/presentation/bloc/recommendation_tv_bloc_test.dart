import 'package:bloc_test/bloc_test.dart';
import 'package:commons/commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetRecommendationTVSeries])
void main() {
  late RecommendationTVBloc recommendationTvsBloc;
  late MockGetRecommendationTVSeries mockGetRecommendationTvs;

  setUp(() {
    mockGetRecommendationTvs = MockGetRecommendationTVSeries();
    recommendationTvsBloc = RecommendationTVBloc(mockGetRecommendationTvs);
  });

  const id = 1;

  test('initial state should be empty', () {
    expect(recommendationTvsBloc.state, RecommendationTVEmpty());
  });

  blocTest<RecommendationTVBloc, RecommendationTVState>(
    'Should emit [RecommendationTvsLoading, RecommendationTvsHasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationTvs.execute(id))
          .thenAnswer((_) async => Right(tTvList));
      return recommendationTvsBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTV(id)),
    expect: () => [
      RecommendationTVLoading(),
      RecommendationTVHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvs.execute(id));
    },
  );

  blocTest<RecommendationTVBloc, RecommendationTVState>(
    'Should emit [RecommendationTvsLoading, RecommendationTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetRecommendationTvs.execute(id))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationTvsBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationTV(id)),
    expect: () => [
      RecommendationTVLoading(),
      const RecommendationTVError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvs.execute(id));
    },
  );
}
