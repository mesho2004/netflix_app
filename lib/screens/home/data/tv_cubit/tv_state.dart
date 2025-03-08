import 'package:netflix_app/core/models/tv_details_model/tv_model.dart';

abstract class TvState {}

class TvInitial extends TvState {}

class TvLoading extends TvState {}

class TvLoaded extends TvState {
  final List<Tv> tv;

  TvLoaded(this.tv);
}

class TvError extends TvState {
  final String errorMessage;

  TvError(this.errorMessage);
}
