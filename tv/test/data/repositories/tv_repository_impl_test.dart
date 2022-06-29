import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:commons/commons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../../../commons/test/helpers/test_helper.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockTVRemoteDataSource;
  late MockTVLocalDataSource mockTVLocalDataSource;

  setUp(() {
    mockTVRemoteDataSource = MockTVRemoteDataSource();
    mockTVLocalDataSource = MockTVLocalDataSource();
    repository = TVRepositoryImpl(
        remoteDataSource: mockTVRemoteDataSource,
        localDataSource: mockTVLocalDataSource);
  });

  group('On The Air TV', () {
    test('Should return list on the air TV when call to data source is success',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getOnTheAirTV())
          .thenAnswer((_) async => tTVmodelList);
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'Should return server failure when call to data source is unsuccessfully',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getOnTheAirTV()).thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'Should return connection failure when device is not connection to the internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getOnTheAirTV())
          .thenThrow(SocketException('Failed to connect to the Network'));
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the Network')));
    });
  });

  group('Popular TV', () {
    test('Should return list popular TV when call to data source is success',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getPopularTV())
          .thenAnswer((_) async => tTVmodelList);
      // act
      final result = await repository.getPopularTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'Should return server failure when call to data source is unsuccessfully',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getPopularTV()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTV();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'Should return connection failure when device is not connection to the internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getPopularTV())
          .thenThrow(SocketException('Failed to connect to the Network'));
      // act
      final result = await repository.getPopularTV();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the Network')));
    });
  });

  group('Recommendation TV', () {
    test(
        'Should return list recommendation TV when call to data source is success',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTVRecommendations(tId))
          .thenAnswer((_) async => tTVmodelList);
      // act
      final result = await repository.getRecommendationTV(tId);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'Should return server failure when call to data source is unsuccessfully',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getRecommendationTV(tId);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'Should return connection failure when device is not connection to the internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the Network'));
      // act
      final result = await repository.getRecommendationTV(tId);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the Network')));
    });
  });

  group('Detail TV', () {
    test('Should return detail TV when call to data source is success',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTVDetail(tId))
          .thenAnswer((_) async => tTVDetailModel);
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      expect(result, equals(Right(tTVDetail)));
    });

    test(
        'Should return server failure when call to data source is unsuccessfully',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTVDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'Should return connection failure when device is not connection to the internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTVDetail(tId))
          .thenThrow(SocketException('Failed to connect to the Network'));
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the Network')));
    });
  });

  group('Top Rated TV', () {
    test('Should return list top rated TV when call to data source is success',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTopRatedTV())
          .thenAnswer((_) async => tTVmodelList);
      // act
      final result = await repository.getTopRatedTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'Should return server failure when call to data source is unsuccessfully',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTopRatedTV()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTV();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'Should return connection failure when device is not connection to the internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTopRatedTV())
          .thenThrow(SocketException('Failed to connect to the Network'));
      // act
      final result = await repository.getTopRatedTV();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the Network')));
    });
  });

  group('Search TV', () {
    test('Should return list search TV when call to data source is success',
        () async {
      // arrange
      when(mockTVRemoteDataSource.searchTV(tQuery))
          .thenAnswer((_) async => tTVmodelList);
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'Should return server failure when call to data source is unsuccessfully',
        () async {
      // arrange
      when(mockTVRemoteDataSource.searchTV(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'Should return connection failure when device is not connection to the internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.searchTV(tQuery))
          .thenThrow(SocketException('Failed to connect to the Network'));
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the Network')));
    });
  });

  group('Save Watchlist TV series', () {
    test('Should return success message when saving successfully', () async {
      // arrange
      when(mockTVLocalDataSource.insertWatchlistTV(tTVTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(tTVDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('Should return Database Failure when saving successfully', () async {
      // arrange
      when(mockTVLocalDataSource.insertWatchlistTV(tTVTable))
          .thenThrow(DatabaseException('Failed to add Watchlist'));
      // act
      final result = await repository.saveWatchlist(tTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add Watchlist')));
    });
  });

  group('Remove Watchlist TV series', () {
    test('Should return success message when remove successfully', () async {
      // arrange
      when(mockTVLocalDataSource.removeWatchlistTV(tTVTable))
          .thenAnswer((_) async => 'Remove from Watchlist');
      // act
      final result = await repository.removeWatchlist(tTVDetail);
      // assert
      expect(result, Right('Remove from Watchlist'));
    });

    test('Should return Database Failure when remove unsucessfully', () async {
      // arrange
      when(mockTVLocalDataSource.removeWatchlistTV(tTVTable))
          .thenThrow(DatabaseException('Failed to remove Watchlist'));
      // act
      final result = await repository.removeWatchlist(tTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove Watchlist')));
    });
  });

  group('Get Watchlist status', () {
    test('Should return watchlist status when data is found', () async {
      // arrange
      when(mockTVLocalDataSource.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('Get Watchlist TV Series', () {
    test('Should return Watchlist TV Series', () async {
      // arrange
      when(mockTVLocalDataSource.getWatchlistTV())
          .thenAnswer((_) async => [tTVTable]);
      // act
      final result = await repository.getWatchlistTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [tWatchlistTV]);
    });
  });
}
