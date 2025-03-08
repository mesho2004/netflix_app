import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:netflix_app/core/constant/apikey.dart';
import 'package:netflix_app/core/models/movie%20model/movie_details_model.dart';
import 'package:netflix_app/core/models/movie%20model/movie_model.dart';
import 'package:netflix_app/core/models/tv_details_model/tv_details_model.dart';
import '../models/tv_details_model/tv_model.dart';

class Api {
  final Dio _dio = Dio();

  static const trending = '${baseUrl}trending/movie/week$key';
  static const upcoming = '${baseUrl}movie/upcoming$key';
  static const nowPlaying = '${baseUrl}movie/now_playing$key';
  static const topRated = '${baseUrl}movie/top_rated$key';
  static const popular = '${baseUrl}movie/popular$key';
  static const airing = '${baseUrl}tv/airing_today$key';
  static const on_the_air = '${baseUrl}tv/on_the_air$key';
  static const popular_tv = '${baseUrl}tv/popular$key';
  static const top_rated_tv = '${baseUrl}tv/top_rated$key';
  static const downloads = "${baseUrl}/trending/all/day$key";

  Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await _dio.get(trending);
      final decodeData = response.data['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } catch (e) {
      log('Error fetching trending movies: $e');
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<Movie>> getUpcomingMovie() async {
    try {
      final response = await _dio.get(upcoming);
      final decodeData = response.data['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } catch (e) {
      log('Error fetching upcoming movies: $e');
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<Movie>> getNowPlaying() async {
    try {
      final response = await _dio.get(nowPlaying);
      final decodeData = response.data['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } catch (e) {
      log('Error fetching now playing movies: $e');
      throw Exception('Failed to load now playing movies');
    }
  }

  Future<List<Movie>> getTopRated() async {
    try {
      final response = await _dio.get(topRated);
      final decodeData = response.data['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } catch (e) {
      log('Error fetching top-rated movies: $e');
      throw Exception('Failed to load top-rated movies');
    }
  }

  Future<List<Movie>> getPopular() async {
    try {
      final response = await _dio.get(popular);
      final decodeData = response.data['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } catch (e) {
      log('Error fetching popular movies: $e');
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> getSearch(String searchText) async {
    final search = '${baseUrl}search/movie$key&query=${searchText}';
    try {
      final response = await _dio.get(search);
      final decodeData = response.data['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } catch (e) {
      log('Error searching for movies: $e');
      throw Exception('Failed to search movies');
    }
  }

  Future<MovieDetailModel> getDetails(int id) async {
    final details = '${baseUrl}movie/$id$key';
    try {
      final response = await _dio.get(details);
      return MovieDetailModel.fromJson(response.data);
    } catch (e) {
      log('Error fetching movie details: $e');
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<Movie>> getRecommendation(int id) async {
    final recommendation = '${baseUrl}movie/$id/recommendations$key';
    try {
      final response = await _dio.get(recommendation);
      final decodeData = response.data['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } catch (e) {
      log('Error fetching movie recommendations: $e');
      throw Exception('Failed to load recommendations');
    }
  }

  Future<List<Tv>> getAirtoday() async {
    try {
      final response = await _dio.get(airing);
      final decodeData = response.data['results'] as List;
      return decodeData.map((tv) => Tv.fromJson(tv)).toList();
    } catch (e) {
      log('Error fetching airing today TV shows: $e');
      throw Exception('Failed to load airing today TV shows');
    }
  }

  Future<List<Tv>> getOnTheAir() async {
    try {
      final response = await _dio.get(on_the_air);
      final decodeData = response.data['results'] as List;
      return decodeData.map((tv) => Tv.fromJson(tv)).toList();
    } catch (e) {
      log('Error fetching on the air TV shows: $e');
      throw Exception('Failed to load on the air TV shows');
    }
  }

  Future<List<Tv>> getPopularTv() async {
    try {
      final response = await _dio.get(popular_tv);
      final decodeData = response.data['results'] as List;
      return decodeData.map((tv) => Tv.fromJson(tv)).toList();
    } catch (e) {
      log('Error fetching popular TV shows: $e');
      throw Exception('Failed to load popular TV shows');
    }
  }

  Future<List<Tv>> getTopRatedTv() async {
    try {
      final response = await _dio.get(top_rated_tv);
      final decodeData = response.data['results'] as List;
      return decodeData.map((tv) => Tv.fromJson(tv)).toList();
    } catch (e) {
      log('Error fetching top rated TV shows: $e');
      throw Exception('Failed to load top rated TV shows');
    }
  }

  Future<List<Tv>> getTvRecommendation(int id) async {
    final recommendation = '${baseUrl}tv/$id/recommendations$key';
    try {
      final response = await _dio.get(recommendation);
      final decodeData = response.data['results'] as List;
      return decodeData.map((tv) => Tv.fromJson(tv)).toList();
    } catch (e) {
      log('Error fetching movie recommendations: $e');
      throw Exception('Failed to load recommendations');
    }
  }

  Future<TvDetailsModel> getTvDetails(int id) async {
    final TvDetails = '${baseUrl}tv/$id$key';
    try {
      final response = await _dio.get(TvDetails);
      return TvDetailsModel.fromJson(response.data);
    } catch (e) {
      log('Error fetching tv details: $e');
      throw Exception('Failed to load tv details');
    }
  }
}
