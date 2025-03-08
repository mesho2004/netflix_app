import 'package:flutter_bloc/flutter_bloc.dart';
import 'recommended_tv_state.dart';
import 'package:netflix_app/core/repos/tv_repo.dart';

class RecommendedTvCubit extends Cubit<RecommendedTvState> {
  final TvRepo tvRepo;

  RecommendedTvCubit({required this.tvRepo}) : super(RecommendedTvLoading());

  Future<void> fetchTvRecommendations(int tvId) async {
    try {
      emit(RecommendedTvLoading());
      final recommendations = await tvRepo.fetchTvRecommendation(tvId);
      emit(RecommendedTvLoaded(tvs: recommendations));
    } catch (e) {
      emit(RecommendedTvError(errorMessage: e.toString()));
    }
  }
}
