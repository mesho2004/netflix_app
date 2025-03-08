import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/screens/all%20details/Models/tv_show_details.dart';
import 'package:netflix_app/screens/all%20details/api/service.dart';
import 'package:netflix_app/screens/all%20details/widgets/add_to_list_button.dart';
import 'package:netflix_app/screens/all%20details/widgets/cart_list.dart';
import 'package:netflix_app/screens/all%20details/widgets/season_list.dart';
import 'package:netflix_app/screens/all%20details/widgets/trailer_player.dart';


class TVShowDetailsScreen extends StatefulWidget {
  final int tvShowId;

  const TVShowDetailsScreen({super.key, required this.tvShowId});

  @override
  State<TVShowDetailsScreen> createState() => _TVShowDetailsScreenState();
}

class _TVShowDetailsScreenState extends State<TVShowDetailsScreen> {
  late Future<TVShowDetails> _tvShowDetailsFuture;
  final TMDBService _tmdbService = TMDBService();

  @override
  void initState() {
    super.initState();
    _tvShowDetailsFuture = _loadTVShowDetails();
  }

  Future<TVShowDetails> _loadTVShowDetails() async {
    final json = await _tmdbService.getTVShowDetails(widget.tvShowId);
    return TVShowDetails.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<TVShowDetails>(
        future: _tvShowDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading TV show details'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final show = snapshot.data!;
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
                        imageUrl: 'https://image.tmdb.org/t/p/original${show.backdropPath}',
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
                    mediaId: show.id,
                    mediaType: 'tv',
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
                        show.name,
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
                            show.firstAirDate.substring(0, 4),
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
                              'IMDb ${show.voteAverage.toStringAsFixed(1)}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (show.trailerKey != null) ...[
                        TrailerPlayer(trailerKey: show.trailerKey!),
                        const SizedBox(height: 16),
                      ],
                      Text(
                        show.overview,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Seasons',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SeasonList(seasons: show.seasons),
                      const SizedBox(height: 24),
                      const Text(
                        'Cast',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CastList(cast: show.castt),
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