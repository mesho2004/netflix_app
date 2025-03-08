import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/constant/apikey.dart';
import 'package:netflix_app/screens/details/presentation/movie/details_screen.dart';
import 'package:netflix_app/screens/details/data/cubit/recommended_movie_cubit/recommended_movie_cubit.dart';
import 'package:netflix_app/screens/details/data/cubit/recommended_movie_cubit/recommended_movie_state.dart';
import 'package:netflix_app/core/repos/movies_repo.dart';

class Recommended extends StatelessWidget {
  final int movieId;
  final MoviesRepo moviesRepo;

  const Recommended(
      {super.key, required this.movieId, required this.moviesRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecommendedMovieCubit(
        moviesRepo: moviesRepo,
      )..fetchRecommendations(movieId),
      child: BlocBuilder<RecommendedMovieCubit, RecommendedState>(
        builder: (context, state) {
          if (state is RecommendedLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is RecommendedError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is RecommendedLoaded) {
            final movies = state.movies;
            if (movies.isEmpty) {
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
                      itemCount: movies.length,
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
                        final movie = movies[index];
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
