// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_info/models/movie.dart';

class MovieCard extends StatelessWidget {
  final List<Movie> movies;
  final int index;

  const MovieCard({Key? key, required this.movies, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius:
                BorderRadius.circular(12), // Adjust the radius as needed
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movies[index].title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                movies[index].overview,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: movies[index]
                    .genres
                    .map(
                      (genre) => Text(
                        genre,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                    .toList(),
              ),
            ],
          )),
    );
  }
}
