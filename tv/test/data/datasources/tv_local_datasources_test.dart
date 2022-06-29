import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:commons/commons.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../../../commons/test/helpers/test_helper.mocks.dart';

void main() {
  late TVLocalDataSourceImpl dataSource;
  late MockDatabaseTVHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseTVHelper();
    dataSource = TVLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTV(tTVTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlistTV(tTVTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTV(tTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistTV(tTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTV(tTVTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlistTV(tTVTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTV(tTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistTV(tTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    const tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTVById(tId)).thenAnswer((_) async => tTVMap);
      // act
      final result = await dataSource.getTVById(tId);
      // assert
      expect(result, tTVTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTVById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTV())
          .thenAnswer((_) async => [tTVMap]);
      // act
      final result = await dataSource.getWatchlistTV();
      // assert
      expect(result, [tTVTable]);
    });
  });
}
