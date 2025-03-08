import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/api/api_service.dart';
import 'package:netflix_app/core/repos/tv_repo.dart';
import 'package:netflix_app/screens/home/data/movie_cubit/movie_cubit.dart';
import 'package:netflix_app/core/repos/movies_repo.dart';
import 'package:netflix_app/screens/home/data/tv_cubit/tv_cubit.dart';
import 'package:netflix_app/screens/home/presentation/screens/moviesScreen.dart';
import 'package:netflix_app/screens/home/presentation/screens/tv_screen.dart';
import 'package:netflix_app/screens/home/presentation/widgets/custom_movie.dart';
import 'package:netflix_app/screens/all%20details/all%20details%20screens/my_list_screen.dart';





class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieCubit(MoviesRepo(Api())),
        ),
        BlocProvider(
          create: (context) => TvCubit(TvRepo(Api())),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Image.asset('assets/logo.png', width: 10),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: Text(
                  "TV Shows",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TvShowsScreen()));
                },
              ),
              TextButton(
                child: Text(
                  "Movies",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MoviesScreen()));
                },
              ),
              TextButton(
                child: Text(
                  "My List",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyListScreen()));
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  "https://i.pinimg.com/736x/11/99/e7/1199e7af4428e98189efd90b454923f5.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 450,
                ),
                Positioned(
                  bottom: 20,
                  child: Column(
                    children: [
                      Text(
                        "#2 in Egypt Today",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.add, color: Colors.white),
                              TextButton(
                                child: Text("My List",
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {},
                              )
                            ],
                          ),
                          SizedBox(width: 20),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.play_arrow),
                            label: Text("Play"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              Icon(Icons.info_outline, color: Colors.white),
                              TextButton(
                                child: Text("Info",
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomMovie(
                title: "Popular Movies on Netflix", movieType: 'popular'),
            SizedBox(height: 10),
            CustomMovie(
                title: "Top 10 Movies in Egypt Today", movieType: 'top'),
            SizedBox(height: 10),
            CustomMovie(
                title: "Trending Movies on Netflix", movieType: 'trending'),
            SizedBox(height: 10),
            CustomMovie(
                title: "Upcoming Movies on Netflix", movieType: 'upcoming'),
            SizedBox(height: 10),
            CustomMovie(
                title: "Now Playing Movies on Netflix",
                movieType: 'now_playing'),
            CustomMovie(title: "On Air Tv Shows", movieType: 'tv_on_air'),
            CustomMovie(
                title: "Airing Now Tv Shows", movieType: 'tv_airing_now'),
            CustomMovie(title: "Top Rated Tv Shows", movieType: 'tv_top'),
            CustomMovie(title: "Popular Tv Shows", movieType: 'tv_popular'),
          ],
        ),
      ),
    );
  }
}
