import 'package:netflix_app/core/api/api_service.dart';
import 'package:netflix_app/core/models/tv_details_model/tv_details_model.dart';
import 'package:netflix_app/core/models/tv_details_model/tv_model.dart';

class TvRepo {
  final Api api;
  TvRepo(this.api);
  Future<List<Tv>> fetchOnAirTv() => api.getOnTheAir();
  Future<List<Tv>> fetchAirTodayTv() => api.getAirtoday();
  Future<List<Tv>> fetchTopRatedTv() => api.getTopRatedTv();
  Future<List<Tv>> fetchPopularTv() => api.getPopularTv();
  Future<TvDetailsModel> fetchTvDetails(int id) => api.getTvDetails(id);
  Future<List<Tv>> fetchTvRecommendation(int id) => api.getTvRecommendation(id);
}
