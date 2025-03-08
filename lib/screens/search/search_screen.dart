import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/constant/apikey.dart';
import 'package:netflix_app/screens/details/presentation/movie/details_screen.dart';
import 'package:netflix_app/screens/search/widgets/search_cubit.dart';
import 'package:netflix_app/screens/search/widgets/top_search.dart';
import 'package:netflix_app/screens/all%20details/all%20details%20screens/movie_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  late SearchCubit searchCubit;

  @override
  void initState() {
    super.initState();
    searchCubit = SearchCubit()..fetchTopSearch();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CupertinoSearchTextField(
                padding: const EdgeInsets.all(10),
                controller: controller,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    searchCubit.searching(value);
                  }
                },
              ),
              BlocBuilder<SearchCubit, SearchState>(
                bloc: searchCubit,
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (state is TopSearchLoaded) {
                    return TopSearch(movies: state.movies);
                  } else if (state is SearchLoaded) {
                    if (state.movies.isEmpty) {
                      return const Text(
                        'No Movies',
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.movies.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1.2 / 2,
                      ),
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsScreen(movieId: movie.id),
                            ),
                          ),
                          child: SizedBox(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 70,
                                  child: movie.backdropPath.isEmpty
                                      ? Image.asset(
                                          'assets/logo.png',
                                          height: 50,
                                        )
                                      : Image.network(
                                          '$imageurl${movie.backdropPath}',
                                          height: 170,
                                        ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    movie.title,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
