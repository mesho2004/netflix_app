import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/screens/all%20details/Models/season.dart';
import 'package:netflix_app/screens/all%20details/all%20details%20screens/season_details_screen.dart';

class SeasonList extends StatelessWidget {
  final List<Season> seasons;

  const SeasonList({super.key, required this.seasons});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: seasons.length,
        itemBuilder: (context, index) {
          final season = seasons[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeasonDetailsScreen(season:season),
                ),
              );
            },
            child: Container(
              width: 140,
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: season.posterPath != null
                          ? 'https://image.tmdb.org/t/p/w200${season.posterPath}'
                          : 'https://via.placeholder.com/200x300',
                      height: 155,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    season.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}