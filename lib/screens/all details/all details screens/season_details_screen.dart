import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/screens/all%20details/Models/episode.dart';
import 'package:netflix_app/screens/all%20details/Models/season.dart';
import 'package:netflix_app/screens/all%20details/api/service.dart';


class SeasonDetailsScreen extends StatefulWidget {
  final Season season;

  const SeasonDetailsScreen({super.key, required this.season});

  @override
  State<SeasonDetailsScreen> createState() => _SeasonDetailsScreenState();
}

class _SeasonDetailsScreenState extends State<SeasonDetailsScreen> {
  late Future<List<Episode>> _episodesFuture;
  final TMDBService _tmdbService = TMDBService();

  @override
  void initState() {
    super.initState();
    _episodesFuture = _loadEpisodes();
  }

  Future<List<Episode>> _loadEpisodes() async {
    final seasonDetails = await _tmdbService.getSeasonDetails(
      widget.season.id,
      widget.season.seasonNumber,
    );
    return (seasonDetails['episodes'] as List)
        .map((episode) => Episode.fromJson(episode))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.season.name),
      ),
      body: FutureBuilder<List<Episode>>(
        future: _episodesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading episodes'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final episodes = snapshot.data!;
          return ListView.builder(
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              final episode = episodes[index];
              return ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: episode.stillPath != null
                        ? 'https://image.tmdb.org/t/p/w200${episode.stillPath}'
                        : 'https://via.placeholder.com/200x112',
                    width: 140,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  '${episode.episodeNumber}. ${episode.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      '${episode.runtime}min • ${episode.airDate}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      episode.overview,
                      style: const TextStyle(color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}