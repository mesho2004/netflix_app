import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/models/movie%20model/movie_model.dart';
import 'package:netflix_app/core/repos/movies_repo.dart';
import 'recommended_movie_state.dart';

class RecommendedMovieCubit extends Cubit<RecommendedState> {
  final MoviesRepo moviesRepo;

  RecommendedMovieCubit({required this.moviesRepo})
      : super(RecommendedLoading());

  Future<void> fetchRecommendations(int id) async {
    try {
      emit(RecommendedLoading());
      final List<Movie> movies = await moviesRepo.fetchRecommendations(id);
      if (movies.isEmpty) {
        emit(RecommendedError("No recommended movies found."));
      } else {
        emit(RecommendedLoaded(movies));
      }
    } catch (e) {
      emit(RecommendedError("Failed to load recommendations: ${e.toString()}"));
    }
  }
}
