import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/api/api_service.dart';
import 'package:netflix_app/screens/details/data/cubit/details_cubit/details_cubit_state.dart';
import 'package:netflix_app/screens/details/data/cubit/recommended_movie_cubit/recommended_movie_cubit.dart';
import 'package:netflix_app/core/repos/movies_repo.dart';
import 'package:netflix_app/screens/details/presentation/movie/widgets/details_image.dart';
import 'package:netflix_app/screens/details/presentation/movie/widgets/details_info.dart';
import 'package:netflix_app/screens/details/presentation/movie/widgets/details_recommended.dart';

class MovieDetail extends StatelessWidget {
  final int id;
  const MovieDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final moviesRepo = MoviesRepo(Api());

    return BlocProvider(
      create: (context) => MovieDetailCubit(Api())..fetchMovieDetails(id),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
            builder: (context, state) {
              if (state is MovieDetailLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              } else if (state is MovieDetailError) {
                return Center(child: Text(state.errorMessage));
              } else if (state is MovieDetailLoaded) {
                final details = state.details;
                final recommendations = state.recommendations;
                String genre =
                    details.genres.map((genre) => genre.name).join(',');

                return Column(
                  children: [
                    DetailImage(height: height, posterPath: details.posterPath),
                    DetailInfo(
                      genre: genre,
                      title: details.title,
                      date: details.releaseDate.year.toString(),
                      overview: details.overview,
                    ),
                    const SizedBox(height: 30),
                    BlocProvider(
                      create: (context) =>
                          RecommendedMovieCubit(moviesRepo: moviesRepo)
                            ..fetchRecommendations(id),
                      child: Recommended(movieId: id, moviesRepo: moviesRepo),
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
