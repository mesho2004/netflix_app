import 'package:netflix_app/core/models/tv_details_model/tv_model.dart';

abstract class RecommendedTvState {}

class RecommendedTvLoading extends RecommendedTvState {}

class RecommendedTvLoaded extends RecommendedTvState {
  final List<Tv> tvs;

  RecommendedTvLoaded({required this.tvs});
}

class RecommendedTvError extends RecommendedTvState {
  final String errorMessage;

  RecommendedTvError({required this.errorMessage});
}
