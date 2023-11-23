import 'dart:convert';

import 'package:testing/api/constants.dart';
import 'package:testing/models/cast.dart';
import 'package:testing/models/movie.dart';
import 'package:http/http.dart' as http;

import '../models/review.dart';

class Api {
  static const trendingUrl =
      "${Constanst.apiUrl}/trending/movie/day?api_key=${Constanst.apiKey}";
  static const topRateUrl =
      "${Constanst.apiUrl}/movie/top_rated?api_key=${Constanst.apiKey}";
  static const upComingUrl =
      "${Constanst.apiUrl}/movie/upcoming?api_key=${Constanst.apiKey}";

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

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse(
        "${Constanst.apiUrl}/search/movie?query=$query&api_key=${Constanst.apiKey}"));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Search Movies Api error");
    }
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    final response = await http.get(Uri.parse(
        "${Constanst.apiUrl}/movie/$movieId/credits?query=&api_key=${Constanst.apiKey}"));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['cast'] as List;
      return decodeData.map((cast) => Cast.fromJson(cast)).toList();
    } else {
      throw Exception("Cast Movies Api error");
    }
  }

  Future<List<Review>> getMovieReview(int movieId) async {
    final response = await http.get(Uri.parse(
        "${Constanst.apiUrl}/movie/$movieId/reviews?query=&api_key=${Constanst.apiKey}"));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      return decodeData.map((review) => Review.fromJson(review)).toList();
    } else {
      throw Exception("Review Movies Api error");
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse("${Constanst.apiUrl}/movie/$movieId?api_key=${Constanst.apiKey}"),
    );

    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      return Movie.fromJson(decodeData);
    } else {
      throw Exception("Get Movie Details API error");
    }
  }
}
