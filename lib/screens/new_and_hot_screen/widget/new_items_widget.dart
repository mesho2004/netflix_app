import 'package:flutter/material.dart';
import 'package:netflix_app/core/models/movie%20model/movie_model.dart';
import 'package:netflix_app/screens/all%20details/Models/movie_deatilsss.dart';

class NewItemsWidget extends StatelessWidget {
  final Movie movie;
  const NewItemsWidget({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          //first column
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FEB',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                
                '14',
                style: TextStyle(
                     color: Colors.white,
                  fontSize: 28, fontWeight: FontWeight.w800),
              )
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          //second column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               SizedBox(
                width: double.infinity,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(movie.fullImageUrl, width: double.infinity,height: 50,fit:  BoxFit.cover,)))
               ,
               const SizedBox(height: 8,),
                Text('Coming in 2025',style: TextStyle(color: Colors.white),),
                const SizedBox(height: 8,),
                Text(
                  movie.overview,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(color: Color.fromARGB(255, 190, 190, 190)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
