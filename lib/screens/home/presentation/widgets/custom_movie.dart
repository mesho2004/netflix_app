import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/api/api_service.dart';
import 'package:netflix_app/screens/details/presentation/tv/tv_details_screen.dart';
import 'package:netflix_app/screens/home/data/movie_cubit/movie_cubit.dart';
import 'package:netflix_app/screens/home/data/movie_cubit/movie_state.dart';
import 'package:netflix_app/screens/home/data/tv_cubit/tv_cubit.dart';
import 'package:netflix_app/screens/home/data/tv_cubit/tv_state.dart';
import 'package:netflix_app/core/models/movie%20model/movie_model.dart';
import 'package:netflix_app/core/models/tv_details_model/tv_model.dart';
import 'package:netflix_app/core/repos/movies_repo.dart';
import 'package:netflix_app/core/repos/tv_repo.dart';
import 'package:netflix_app/screens/details/presentation/movie/details_screen.dart';
import 'package:netflix_app/screens/all%20details/all%20details%20screens/movie_details_screen.dart';
import 'package:netflix_app/screens/all%20details/all%20details%20screens/tv_show_details_screen.dart';

class CustomMovie extends StatelessWidget {
  const CustomMovie({required this.title, required this.movieType});
  final String title;
  final String movieType;

  @override
  Widget build(BuildContext context) {
    if (movieType.contains('tv')) {
      return BlocProvider<TvCubit>(
        create: (context) {
          final tvCubit = TvCubit(TvRepo(Api()));
          switch (movieType) {
            case 'tv_popular':
              tvCubit.fetchPopularTv();
              break;
            case 'tv_top':
              tvCubit.fetchTopRatedTv();
              break;
            case 'tv_on_air':
              tvCubit.fetchOnAirTv();
              break;
            default:
              tvCubit.fetchAiringNowTv();
          }
          return tvCubit;
        },
        child: buildContent<TvCubit, TvState>(
          context,
          title,
          (state) {
            if (state is TvLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TvLoaded) {
              return _buildTvShowsList(state.tv, context);
            } else if (state is TvError) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const Center(child: Text('No TV shows found.'));
            }
          },
        ),
      );
    } else {
      return BlocProvider<MovieCubit>(
        create: (context) {
          final movieCubit = MovieCubit(MoviesRepo(Api()));
          switch (movieType) {
            case 'popular':
              movieCubit.fetchPopularMovies();
              break;
            case 'top':
              movieCubit.fetchTopRatedMovies();
              break;
            case 'upcoming':
              movieCubit.fetchUpComingMovies();
              break;
            case 'now_playing':
              movieCubit.fetchNowPlayingMovies();
              break;
            default:
              movieCubit.fetchTrendingMovies();
          }
          return movieCubit;
        },
        child: buildContent<MovieCubit, MovieState>(
          context,
          title,
          (state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieLoaded) {
              return _buildMoviesList(state.movies, context);
            } else if (state is MovieError) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const Center(child: Text('No movies found.'));
            }
          },
        ),
      );
    }
  }

  Widget buildContent<C extends Cubit<S>, S>(
    BuildContext context,
    String title,
    Widget Function(S state) builder,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: BlocBuilder<C, S>(
            builder: (context, state) => builder(state),
          ),
        ),
      ],
    );
  }

  Widget _buildMoviesList(List<Movie> movies, BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(movieId: movie.id),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                movie.fullImageUrl,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTvShowsList(List<Tv> tvShows, BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: tvShows.length,
      itemBuilder: (context, index) {
        final tvShow = tvShows[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TVShowDetailsScreen(tvShowId: tvShow.id),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                tvShow.fullImageUrl,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
