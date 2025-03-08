import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/screens/all%20details/all%20details%20screens/movie_details_screen.dart';
import 'package:netflix_app/screens/all%20details/all%20details%20screens/tv_show_details_screen.dart';

import 'add_to_list_button.dart';

class MediaCard extends StatelessWidget {
  final int id;
  final String title;
  final String? posterPath;
  final String mediaType;
  final VoidCallback? onListUpdated;

  const MediaCard({
    super.key,
    required this.id,
    required this.title,
    this.posterPath,
    required this.mediaType,
    this.onListUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => mediaType == 'movie'
                ? MovieDetailsScreen(movieId: id)
                : TVShowDetailsScreen(tvShowId: id),
          ),
        ).then((_) => onListUpdated?.call());
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: posterPath != null
                  ? 'https://image.tmdb.org/t/p/w500$posterPath'
                  : 'https://via.placeholder.com/500x750',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[900],
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[900],
                child: const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: AddToListButton(
              mediaId: id,
              mediaType: mediaType,
              onListUpdated: onListUpdated,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}