import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/constant/apikey.dart';
import 'package:netflix_app/core/repos/tv_repo.dart';
import 'package:netflix_app/screens/details/data/cubit/recommended_tv/recommended_tv_cubit.dart';
import 'package:netflix_app/screens/details/data/cubit/recommended_tv/recommended_tv_state.dart';
import 'package:netflix_app/screens/details/presentation/movie/details_screen.dart';

class TvRecommended extends StatelessWidget {
  final int TvId;
  final TvRepo tvRepo;

  const TvRecommended({super.key, required this.TvId, required this.tvRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecommendedTvCubit(
        tvRepo: tvRepo,
      )..fetchTvRecommendations(TvId),
      child: BlocBuilder<RecommendedTvCubit, RecommendedTvState>(
        builder: (context, state) {
          if (state is RecommendedTvLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is RecommendedTvError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is RecommendedTvLoaded) {
            final tvs = state.tvs;
            if (tvs.isEmpty) {
              return const Text('No Details');
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'More like this',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    fit: FlexFit.loose,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: tvs.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        final movie = tvs[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetail(id: movie.id),
                              ),
                            );
                          },
                          child: AspectRatio(
                            aspectRatio: 0.7,
                            child: Column(
                              children: [
                                Image.network(
                                  '$imageurl${movie.posterPath}',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
