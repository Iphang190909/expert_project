import 'package:bloc_test/bloc_test.dart';
import 'package:commons/commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:dartz/dartz.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_movie_bloc.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendMoviesBloc recommendMoviesBloc;
  late MockGetMovieRecommendations mockGetRecommendationMovies;

  setUp(() {
    mockGetRecommendationMovies = MockGetMovieRecommendations();
    recommendMoviesBloc = RecommendMoviesBloc(mockGetRecommendationMovies);
  });

  const id = 1;

  test('initial state should be empty', () {
    expect(RecommendMoviesBloc, RecommendMoviesEmpty());
  });

  blocTest<RecommendMoviesBloc, RecommendMoviesState>(
    'Should emit [RecommendationMoviesLoading, RecommendationMoviesHasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationMovies.execute(id))
          .thenAnswer((_) async => Right(testMovieList));
      return recommendMoviesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendMovies(id)),
    expect: () => [
      RecommendMoviesLoading(),
      RecommendMoviesHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovies.execute(id));
    },
  );

  blocTest<RecommendMoviesBloc, RecommendMoviesState>(
    'Should emit [RecommendationMoviesLoading, RecommendationMoviesError] when get data is unsuccessful',
    build: () {
      when(mockGetRecommendationMovies.execute(id))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendMoviesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendMovies(id)),
    expect: () => [
      RecommendMoviesLoading(),
      const RecommendMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovies.execute(id));
    },
  );
}
