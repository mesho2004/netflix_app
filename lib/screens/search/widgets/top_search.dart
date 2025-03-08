import 'package:flutter/material.dart';
import 'package:netflix_app/core/constant/apikey.dart';
import 'package:netflix_app/core/models/movie%20model/movie_model.dart';
import 'package:netflix_app/screens/details/presentation/movie/details_screen.dart';
import 'package:netflix_app/screens/all%20details/all%20details%20screens/movie_details_screen.dart';

class TopSearch extends StatelessWidget {
  final List<Movie>? movies;
  const TopSearch({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text('Top Searches',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(
          height: 20,
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: movies?.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final movie = movies![index];

              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movieId: movie.id))),
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Image.network('$imageurl${movie.posterPath}'),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 260,
                        child: Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }
}
