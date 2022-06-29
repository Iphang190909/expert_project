import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../dummy_data/dummy_objects.dart';
import '../../../../commons/test/helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TVRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() => {
        mockHttpClient = MockHttpClient(),
        dataSource = TVRemoteDataSourceImpl(client: mockHttpClient)
      });

  group('Get on the air TV', () {
    final tTVList =
        TVResponse.fromJson(json.decode(readJson('dummy_data/on_the_air.json')))
            .tvlist;

    test('Should return list of on the airing TV when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air.json'), 200));
      // act
      final result = await dataSource.getOnTheAirTV();
      // assert
      expect(result, equals(tTVList));
    });

    test('Should throw a ServerExeption when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final result = dataSource.getOnTheAirTV();
      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('Get on TV detail', () {
    final tTVDetail = TVDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('Should return TV detail when status code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/$tId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTVDetail(tId);
      // assert
      expect(result, equals(tTVDetail));
    });

    test(
        'Should throw Server Exception when response code 404 or other in TV detail',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get on TV recommendation', () {
    final int tId = 1;
    final tTVRecommendation = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendation.json')))
        .tvlist;

    test('Should return TV Recommendation when response is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseURL/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendation.json'), 200));
      // act
      final result = await dataSource.getTVRecommendations(tId);
      // assert
      expect(result, equals(tTVRecommendation));
    });

    test(
        'Should throw Server Exception when response code 404 or other in TV recommendation',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseURL/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get on TV top rated', () {
    final tTVTopRatedList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_top_rated.json')))
        .tvlist;

    test('Should return TV top rated when response status code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/top_rated?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTV();
      // assert
      expect(result, equals(tTVTopRatedList));
    });

    test(
        'Should throw Server Exception when response code 404 or other from TV top rated',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTV();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get on TV from search', () {
    const tQuery = 'The Amazing Spiderman';
    final tTVSearchList =
        TVResponse.fromJson(json.decode(readJson('dummy_data/tv_search.json')))
            .tvlist;

    test('Should return list TV from search when status code is 200', () async {
      // assert
      when(mockHttpClient
              .get(Uri.parse('$baseURL/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_search.json'), 200));
      // act
      final result = await dataSource.searchTV(tQuery);
      // assert
      expect(result, equals(tTVSearchList));
    });
  });
}
