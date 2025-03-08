import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/api/api_service.dart';
import 'package:netflix_app/core/models/movie%20model/movie_details_model.dart';
import 'package:netflix_app/core/models/movie%20model/movie_model.dart';
import 'package:netflix_app/core/models/tv_details_model/tv_details_model.dart';
import 'package:netflix_app/core/models/tv_details_model/tv_model.dart';

abstract class TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TvDetailsModel details;
  final List<Tv> recommendations;

  TvDetailLoaded(this.details, this.recommendations);
}

class TvDetailError extends TvDetailState {
  final String errorMessage;

  TvDetailError(this.errorMessage);
}

class TvDetailCubit extends Cubit<TvDetailState> {
  final Api api;

  TvDetailCubit(this.api) : super(TvDetailLoading());

  Future<void> fetchTvDetails(int id) async {
    try {
      final details = await api.getTvDetails(id);
      final recommendations = await api.getTvRecommendation(id);
      emit(TvDetailLoaded(details, recommendations));
    } catch (e) {
      emit(TvDetailError("Failed to load Tv details: ${e.toString()}"));
    }
  }
}
