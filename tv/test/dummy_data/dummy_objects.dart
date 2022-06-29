import 'package:tv/tv.dart';

const tId = 1;
const String tQuery = 'The Amazing Spiderman';

final tTVDetail = TvDetail(
    backdropPath: 'backdropPath',
    id: 1,
    genres: const [GenreTv(id: 1, name: 'Name')],
    originalName: 'original Name',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    voteAvarage: 1.0,
    voteCount: 23,
    name: 'name',
    popularity: 1000);

const tTVDetailModel = TVDetailModel(
    backdropPath: 'backdropPath',
    id: 1,
    genres: [GenreTVModel(id: 1, name: 'Name')],
    originalName: 'original Name',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    voteAvarage: 1.0,
    voteCount: 23,
    name: 'name',
    popularity: 1000);

final tTv = TV(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3, 4],
    id: 1,
    name: 'name',
    originalName: 'original name',
    overview: 'overview',
    posterPath: 'poster path',
    voteAverage: 1.0,
    voteCount: 123,
    popularity: 2003);

final tTvList = <TV>[tTv];

const tTVModel = TVModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: 'name',
    originalName: 'original name',
    overview: 'overview',
    posterPath: 'poster path',
    voteAverage: 1.0,
    voteCount: 123,
    popularity: 2003);

final tTVmodelList = <TVModel>[tTVModel];

const tTVTable = TVTable(
    id: 1, name: 'name', posterPath: 'posterPath', overview: 'overview');

final tWatchlistTV = TV.whatchlist(
    id: 1, overview: 'overview', posterPath: 'posterPath', name: 'name');

final tTVMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};
