import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/screens/all%20details/Models/cast.dart';

class CastList extends StatelessWidget {
  final List<Casting> cast;

  const CastList({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        itemBuilder: (context, index) {
          final actor = cast[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: actor.profilePath != null
                      ? CachedNetworkImageProvider(
                          'https://image.tmdb.org/t/p/w200${actor.profilePath}',
                        )
                      : null,
                  child: actor.profilePath == null
                      ? const Icon(Icons.person, size: 35)
                      : null,
                ),
                const SizedBox(height: 4),
                Text(
                  actor.name,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}