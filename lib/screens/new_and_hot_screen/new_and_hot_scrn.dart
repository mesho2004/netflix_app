import 'package:flutter/material.dart';
import 'package:netflix_app/core/api/api_service.dart';
import 'package:netflix_app/core/models/movie%20model/movie_model.dart';
import 'package:netflix_app/screens/new_and_hot_screen/widget/new.dart';
import 'package:netflix_app/screens/new_and_hot_screen/widget/new_items_widget.dart';



class NewAndHotScrn extends StatelessWidget {

  const NewAndHotScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
          body:  Column(
          children: [
              const SizedBox(
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                 SelectOptionsWidget(title: '🍿 Coming Soon'),
                 SelectOptionsWidget(title: "🔥 Everyone's Watching"),
                 SelectOptionsWidget(title: '🎮 Games'),
                 SelectOptionsWidget(title: '🔝 Top Tv Shows'),   
                  SelectOptionsWidget(title: '🔝 Top Tv Movies'),   
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20, 
          ),
            FutureBuilder(
                future: Api().getUpcomingMovie(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Center(
                        child: Text('No data available'),
                      ),
                    );
                  } else {
                    List<Movie> movie = snapshot.data!;
                    return Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            
                            return NewItemsWidget(movie: movie[index],);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 20,
                              ),
                          itemCount: movie.length),
                    );
                  }
                }),
          ],
        )
      ),
    );
  }
}
