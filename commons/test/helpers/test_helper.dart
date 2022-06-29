import 'package:commons/commons.dart';
import 'package:tv/tv.dart';
import 'package:movies/movies.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  TVRepository,
  MovieRemoteDataSource,
  TVRemoteDataSource,
  MovieLocalDataSource,
  TVLocalDataSource,
  DatabaseMovieHelper,
  NetworkInfo,
  DatabaseTVHelper
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
