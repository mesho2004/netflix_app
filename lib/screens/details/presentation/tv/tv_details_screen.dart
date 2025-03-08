import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/api/api_service.dart';
import 'package:netflix_app/core/repos/tv_repo.dart';
import 'package:netflix_app/screens/details/data/cubit/recommended_tv/recommended_tv_cubit.dart';
import 'package:netflix_app/screens/details/data/cubit/tv_details_cubit/tv_details_cubit.dart';
import 'package:netflix_app/screens/details/presentation/tv/widgets/details_image.dart';
import 'package:netflix_app/screens/details/presentation/tv/widgets/details_info.dart';
import 'package:netflix_app/screens/details/presentation/tv/widgets/details_recommended.dart';

class TvDetail extends StatelessWidget {
  final int id;
  const TvDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final tvRepo = TvRepo(Api());

    return BlocProvider(
      create: (context) => TvDetailCubit(Api())..fetchTvDetails(id),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocBuilder<TvDetailCubit, TvDetailState>(
            builder: (context, state) {
              if (state is TvDetailLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              } else if (state is TvDetailError) {
                return Center(child: Text(state.errorMessage));
              } else if (state is TvDetailLoaded) {
                final details = state.details;
                String genre =
                    details.genres.map((genre) => genre.name).join(',');

                return Column(
                  children: [
                    TvDetailImage(
                        height: height, posterPath: details.posterPath ?? ""),
                    TvDetailInfo(
                      genre: genre,
                      title: details.name ?? "",
                      date: details.firstAirDate.toString(),
                      overview: details.overview ?? "",
                    ),
                    const SizedBox(height: 30),
                    BlocProvider(
                      create: (context) => RecommendedTvCubit(tvRepo: tvRepo)
                        ..fetchTvRecommendations(id),
                      child: TvRecommended(TvId: id, tvRepo: tvRepo),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
