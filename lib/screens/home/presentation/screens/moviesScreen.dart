import 'package:flutter/material.dart';
import 'package:netflix_app/screens/home/presentation/widgets/custom_movie.dart';

class MoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Movies'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          CustomMovie(title: "Popular Movies", movieType: 'popular'),
          SizedBox(height: 10),
          CustomMovie(title: "Top 10 Movies", movieType: 'top'),
          SizedBox(height: 10),
          CustomMovie(title: "Trending Movies", movieType: 'trending'),
          SizedBox(height: 10),
          CustomMovie(title: "Upcoming Movies", movieType: 'upcoming'),
          SizedBox(height: 10),
          CustomMovie(title: "Now Playing Movies", movieType: 'now_playing'),
        ],
      ),
    );
  }
}