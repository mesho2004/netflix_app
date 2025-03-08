import 'package:flutter/material.dart';
import 'package:netflix_app/screens/home/presentation/widgets/custom_movie.dart';

class TvShowsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('TV Shows'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          CustomMovie(title: "On Air TV Shows", movieType: 'tv_on_air'),
          SizedBox(height: 10),
          CustomMovie(title: "Airing Now", movieType: 'tv_airing_now'),
          SizedBox(height: 10),
          CustomMovie(title: "Top Rated TV Shows", movieType: 'tv_top'),
          SizedBox(height: 10),
          CustomMovie(title: "Popular TV Shows", movieType: 'tv_popular'),
        ],
      ),
    );
  }
}