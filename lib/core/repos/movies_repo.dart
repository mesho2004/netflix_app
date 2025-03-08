import 'package:netflix_app/core/api/api_service.dart';
import 'package:netflix_app/core/models/movie%20model/movie_details_model.dart';
import 'package:netflix_app/core/models/movie%20model/movie_model.dart';

class MoviesRepo {
  final Api api;

  MoviesRepo(this.api);

  Future<List<Movie>> fetchTrendingMovies() => api.getTrendingMovies();
  Future<List<Movie>> fetchUpcomingMovies() => api.getUpcomingMovie();
  Future<List<Movie>> fetchNowPlayingMovies() => api.getNowPlaying();
  Future<List<Movie>> fetchTopRatedMovies() => api.getTopRated();
  Future<List<Movie>> fetchPopularMovies() => api.getPopular();
  Future<MovieDetailModel> fetchMovieDetails(int id) => api.getDetails(id);
  Future<List<Movie>> fetchRecommendations(int id) => api.getRecommendation(id);
  Future<List<Movie>> searchMovies(String query) => api.getSearch(query);
}
