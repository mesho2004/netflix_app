import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:netflix_app/core/models/movie%20model/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TMDBService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _apiKey = '1fe2d8f35096ba9efd648c7d05ccf80d';
    static const String _watchlistKey = 'watchlist';

  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/movie/$movieId',
        queryParameters: {
          'api_key': _apiKey,
          'append_to_response': 'videos,credits',
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to load movie details');
    }
  }

  Future<Map<String, dynamic>> getTVShowDetails(int tvId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/tv/$tvId',
        queryParameters: {
          'api_key': _apiKey,
          'append_to_response': 'videos,credits',
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to load TV show details');
    }
  }

  Future<Map<String, dynamic>> getSeasonDetails(int tvId, int seasonNumber) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/tv/$tvId/season/$seasonNumber',
        queryParameters: {
          'api_key': _apiKey,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to load season details');
    }
  }

 Future<void> addToList(int mediaId, String mediaType) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final watchlistString = prefs.getString(_watchlistKey);
      final List<Map<String, dynamic>> watchlist = watchlistString != null
          ? List<Map<String, dynamic>>.from(json.decode(watchlistString))
          : [];

      final existingItemIndex = watchlist.indexWhere(
        (item) => item['mediaId'] == mediaId && item['mediaType'] == mediaType,
      );

      if (existingItemIndex == -1) {
        watchlist.add({
          'mediaId': mediaId,
          'mediaType': mediaType,
          'dateAdded': DateTime.now().toIso8601String(),
        });
        await prefs.setString(_watchlistKey, json.encode(watchlist));
      }
    } catch (e) {
      throw Exception('Failed to add to watchlist: $e');
    }
  }

Future<void> removeFromList(int mediaId, String mediaType) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final watchlistString = prefs.getString(_watchlistKey);
    final watchlist = watchlistString != null
        ? List<Map<String, dynamic>>.from(json.decode(watchlistString))
        : [];

    watchlist.removeWhere(
      (item) => item['mediaId'] == mediaId && item['mediaType'] == mediaType,
    );

    await prefs.setString(_watchlistKey, json.encode(watchlist));
  } catch (e) {
    throw Exception('Failed to remove from watchlist');
  }
}

Future<List<Map<String, dynamic>>> getMyList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final watchlistString = prefs.getString(_watchlistKey);
      if (watchlistString == null) {
        return [];
      }

      final List<Map<String, dynamic>> watchlist = List<Map<String, dynamic>>.from(
        json.decode(watchlistString),
      );

      // Fetch detailed information for each item in the watchlist
      final List<Map<String, dynamic>> detailedList = [];
      
      for (var item in watchlist) {
        try {
          final int mediaId = item['mediaId'];
          final String mediaType = item['mediaType'];
          
          final response = await _dio.get(
            '$_baseUrl/$mediaType/$mediaId',
            queryParameters: {
              'api_key': _apiKey,
            },
          );

          if (response.statusCode == 200) {
            final details = response.data;
            details['media_type'] = mediaType; // Add media_type to the response
            detailedList.add(details);
          }
        } catch (e) {
          print('Error fetching details for item: ${item['mediaId']} - $e');
          continue;
        }
      }

      return detailedList;
    } catch (e) {
      throw Exception('Failed to load watchlist: $e');
    }
  }


  Future<bool> isInWatchlist(int mediaId, String mediaType) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final watchlistString = prefs.getString(_watchlistKey);
      final watchlist = watchlistString != null
          ? List<Map<String, dynamic>>.from(json.decode(watchlistString))
          : [];

      return watchlist.any(
        (item) => item['mediaId'] == mediaId && item['mediaType'] == mediaType,
      );
    } catch (e) {
      return false;
    }
  }
}