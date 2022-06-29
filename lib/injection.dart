import 'package:commons/commons.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:movies/movies.dart';

import 'package:get_it/get_it.dart';
import 'package:tv/tv.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  // Movie
  locator.registerFactory(
    () => NowPlayingMovieBloc(locator()),
  );
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(
    () => DetailMovieBloc(locator()),
  );
  locator.registerFactory(
    () => SearchMovieBloc(locator()),
  );
  locator.registerFactory(
    () => RecommendMoviesBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(locator(), locator(), locator(), locator()),
  );
  // TV
  locator.registerFactory(() => DetailTVBloc(locator()));
  locator.registerFactory(() => OnTheAirTVBloc(locator()));
  locator.registerFactory(() => PopularTVBloc(locator()));
  locator.registerFactory(() => RecommendationTVBloc(locator()));
  locator.registerFactory(() => SearchTVBloc(locator()));
  locator.registerFactory(() => TopRatedTVBloc(locator()));
  locator.registerFactory(
      () => WatchlistTVBloc(locator(), locator(), locator(), locator()));

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case TV
  locator.registerLazySingleton(() => GetOnTheAirTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTvDetailSeries(locator()));
  locator.registerLazySingleton(() => GetRecommendationTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVWatchList(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => SaveTVWatchlist(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => GetWatchListTVStatus(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkInfo: locator()),
  );
  locator.registerLazySingleton<TVRepository>(() => TVRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator
      .registerLazySingleton<DatabaseMovieHelper>(() => DatabaseMovieHelper());
  locator.registerLazySingleton<DatabaseTVHelper>(() => DatabaseTVHelper());

  // external
  locator.registerLazySingleton(() => HTTPSPinning.client);
  locator.registerLazySingleton(() => DataConnectionChecker());
}
