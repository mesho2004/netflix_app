import 'package:netflix_app/core/models/movie%20model/movie_model.dart';

abstract class RecommendedState {}

class RecommendedLoading extends RecommendedState {}

class RecommendedLoaded extends RecommendedState {
  final List<Movie> movies;

  RecommendedLoaded(this.movies);
}

class RecommendedError extends RecommendedState {
  final String errorMessage;
  RecommendedError(this.errorMessage);
}
