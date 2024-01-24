// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_info/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_info/models/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = [];

  List<String> test = [];

  Future getMovies() async {
    for (int i = 1; i < 10; i++) {
      List<String> genres = [];

      var response = await http.get(Uri.https("api.themoviedb.org",
          "3/movie/$i", {"api_key": "6e68f6814629f7c082de4f90f23adeb1"}));
      var jsonData = jsonDecode(response.body);
      var jsonString = jsonEncode(jsonData);

      try {
        for (var genre in jsonData['genres']) {
          genres.add(genre['name']);
        }
        var movie = Movie(
            title: jsonData['title'],
            overview: jsonData['overview'],
            genre: genres);

        movies.add(movie);

        test.add(jsonString);
      } catch (e) {
        // continue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: movies.length,
                    padding: EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      return MovieCard(movies: movies,index: index,);
                    });
                // return Text(movies.length.toString());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
