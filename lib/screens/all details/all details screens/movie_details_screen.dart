import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/screens/all%20details/Models/movie_deatilsss.dart';
import 'package:netflix_app/screens/all%20details/api/service.dart';
import 'package:netflix_app/screens/all%20details/widgets/add_to_list_button.dart';
import 'package:netflix_app/screens/all%20details/widgets/cart_list.dart';
import 'package:netflix_app/screens/all%20details/widgets/trailer_player.dart';


class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieDetailsss> _movieDetailsFuture;
  final TMDBService _tmdbService = TMDBService();

  @override
  void initState() {
    super.initState();
    _movieDetailsFuture = _loadMovieDetails();
  }

  Future<MovieDetailsss> _loadMovieDetails() async {
    final json = await _tmdbService.getMovieDetails(widget.movieId);
    return MovieDetailsss.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<MovieDetailsss>(
        future: _movieDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading movie details'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final movie = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: 'https://image.tmdb.org/t/p/original${movie.backdropPath}',
                        fit: BoxFit.cover,
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  AddToListButton(
                    mediaId: movie.id,
                    mediaType: 'movie',
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            movie.releaseDate.substring(0, 4),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'IMDb ${movie.voteAverage.toStringAsFixed(1)}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (movie.trailerKey != null) ...[
                        TrailerPlayer(trailerKey: movie.trailerKey!),
                        const SizedBox(height: 16),
                      ],
                      Text(
                        movie.overview,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Cast',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CastList(cast: movie.cast),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}