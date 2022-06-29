import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/tv.dart';

import '../../json_reader.dart';

void main() {
  const tTvModel = TVModel(
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: "Moon Knight",
    originalName: "Moon Knight",
    overview: 'overview',
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1,
    voteCount: 1,
  );

  const tTvResponseModel = TVResponse(tvlist: <TVModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "name": "Moon Knight",
            "original_name": "Moon Knight",
            "overview": "overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
