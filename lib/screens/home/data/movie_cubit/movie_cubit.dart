import 'package:bloc/bloc.dart';
import 'package:netflix_app/core/repos/movies_repo.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MoviesRepo movieRepository;

  MovieCubit(this.movieRepository) : super(MovieInitial());

  void fetchTrendingMovies() async {
    if (isClosed) return;

    try {
      emit(MovieLoading());
      final movies = await movieRepository.fetchTrendingMovies();
      emit(MovieLoaded(movies));
    } catch (error) {
      if (!isClosed) {
        emit(MovieError('Failed to load trending movies: $error'));
      }
    }
  }

  void fetchNowPlayingMovies() async {
    if (isClosed) return;

    try {
      emit(MovieLoading());
      final movies = await movieRepository.fetchNowPlayingMovies();
      emit(MovieLoaded(movies));
    } catch (error) {
      if (!isClosed) {
        emit(MovieError('Failed to load trending movies: $error'));
      }
    }
  }

  void fetchUpComingMovies() async {
    if (isClosed) return;

    try {
      emit(MovieLoading());
      final movies = await movieRepository.fetchUpcomingMovies();
      emit(MovieLoaded(movies));
    } catch (error) {
      if (!isClosed) {
        emit(MovieError('Failed to load upcoming movies: $error'));
      }
    }
  }

  void fetchPopularMovies() async {
    if (isClosed) return;

    try {
      emit(MovieLoading());
      final movies = await movieRepository.fetchPopularMovies();
      emit(MovieLoaded(movies));
    } catch (error) {
      if (!isClosed) {
        emit(MovieError('Failed to load popular movies: $error'));
      }
    }
  }

  void fetchTopRatedMovies() async {
    if (isClosed) return;

    try {
      emit(MovieLoading());
      final movies = await movieRepository.fetchTopRatedMovies();
      emit(MovieLoaded(movies));
    } catch (error) {
      if (!isClosed) {
        emit(MovieError('Failed to load top-rated movies: $error'));
      }
    }
  }
}
