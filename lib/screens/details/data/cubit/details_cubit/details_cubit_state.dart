import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/api/api_service.dart';
import 'package:netflix_app/core/models/movie%20model/movie_details_model.dart';
import 'package:netflix_app/core/models/movie%20model/movie_model.dart';

abstract class MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailModel details;
  final List<Movie> recommendations;

  MovieDetailLoaded(this.details, this.recommendations);
}

class MovieDetailError extends MovieDetailState {
  final String errorMessage;

  MovieDetailError(this.errorMessage);
}

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final Api api;

  MovieDetailCubit(this.api) : super(MovieDetailLoading());

  Future<void> fetchMovieDetails(int id) async {
    try {
      final details = await api.getDetails(id);
      final recommendations = await api.getRecommendation(id);
      emit(MovieDetailLoaded(details, recommendations));
    } catch (e) {
      emit(MovieDetailError("Failed to load movie details: ${e.toString()}"));
    }
  }
}
