import 'dart:convert';

import 'package:testing/constants.dart';
import 'package:testing/models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  static const trendingUrl =
      "${Constanst.apiUrl}/trending/movie/day?api_key=${Constanst.apiKey}";
  static const topRateUrl =
      "${Constanst.apiUrl}/movie/top_rated?api_key=${Constanst.apiKey}";
  static const upComingUrl =
      "${Constanst.apiUrl}/movie/upcoming?api_key=${Constanst.apiKey}";
  static const nowPlayingUrl =
      "${Constanst.apiUrl}/movie/now_playing?api_key=${Constanst.apiKey}";

  Future<List<Movie>> getTrengdingMovies() async {
    final response = await http.get(Uri.parse(trendingUrl)); // lay api tu link
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Get Trengding Movies Api error");
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(topRateUrl)); // lay api tu link
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Get TopRated Movies Api error");
    }
  }

  Future<List<Movie>> getUpComingMovies() async {
    final response = await http.get(Uri.parse(upComingUrl)); // lay api tu link
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Get UpComing Movies Api error");
    }
  }

  Future<List<Movie>> getNowplayingMovies() async {
    final response =
        await http.get(Uri.parse(nowPlayingUrl)); // lay api tu link
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Get NowPlaying Movies Api error");
    }
  }
}
