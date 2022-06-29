import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';

abstract class TVRemoteDataSource {
  Future<List<TVModel>> getOnTheAirTV();
  Future<List<TVModel>> getPopularTV();
  Future<List<TVModel>> getTopRatedTV();
  Future<TVDetailModel> getTVDetail(int id);
  Future<List<TVModel>> getTVRecommendations(int id);
  Future<List<TVModel>> searchTV(String query);
}

class TVRemoteDataSourceImpl implements TVRemoteDataSource {
  final http.Client client;

  TVRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVModel>> getOnTheAirTV() async {
    final response =
        await client.get(Uri.parse('$baseURL/tv/on_the_air?$apiKey'));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvlist;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getPopularTV() async {
    final response = await client.get(Uri.parse('$baseURL/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvlist;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVDetailModel> getTVDetail(int id) async {
    final response = await client.get(Uri.parse('$baseURL/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TVDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTVRecommendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseURL/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvlist;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTopRatedTV() async {
    final response =
        await client.get(Uri.parse('$baseURL/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvlist;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> searchTV(String query) async {
    final response =
        await client.get(Uri.parse('$baseURL/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvlist;
    } else {
      throw ServerException();
    }
  }
}
