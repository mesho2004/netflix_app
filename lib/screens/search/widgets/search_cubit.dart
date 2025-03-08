import 'package:bloc/bloc.dart';
import 'package:netflix_app/core/api/api_service.dart';
import 'package:netflix_app/core/models/movie%20model/movie_model.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final Api api = Api();

  void fetchTopSearch() async {
    emit(SearchLoading());
    try {
      final movies = await api.getTopRated();
      emit(TopSearchLoaded(movies));
    } catch (e) {
      emit(SearchError("Failed to load top search movies"));
    }
  }

  void searching(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      final movies = await api.getSearch(query);
      emit(SearchLoaded(movies));
    } catch (e) {
      emit(SearchError("Failed to search movies"));
    }
  }
}

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Movie> movies;
  SearchLoaded(this.movies);
}

class TopSearchLoaded extends SearchState {
  final List<Movie> movies;
  TopSearchLoaded(this.movies);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
