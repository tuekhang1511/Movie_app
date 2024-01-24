// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_info/models/genre.dart';
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

  List<Movie> filteredMovies = [];

  List<String> genres = [];

  List<String> genresBar = [];

  List<List<Object>> genresWithFlags = [];

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
            genres: genres);

        // if (movies.every((movie2) => movie2.title != movie.title)) {
        movies.add(movie);
        // }

        test.add(jsonString);
      } catch (e) {
        // continue;
      }
    }

    for (Movie movie in movies) {
      for (String genre in movie.genres) {
        if (!genresBar.contains(genre)) {
          genresBar.add(genre);
        }
      }
    }

    for (String genre in genresBar) {
      bool genreExists = false;

      for (int i = 0; i < genresWithFlags.length; i++) {
        if (genresWithFlags[i][0] == genre) {
          // Genre already exists in genresWithFlags
          genreExists = true;
          break;
        }
      }

      if (!genreExists) {
        // Genre does not exist in genresWithFlags, add it
        genresWithFlags.add([genre, false]);
      }
    }

    for (List<Object> genre in genresWithFlags) {
      if (genre[1] == true) {
        String selectedGenre = genre[0].toString();

        filteredMovies.addAll(movies.where((movie) {
          return movie.genres.contains(selectedGenre);
        }).toList());
        // Convert to Set to remove duplicates
        Set<Movie> uniqueSet = Set<Movie>.from(filteredMovies);

        // Convert back to List (if needed)
        filteredMovies = uniqueSet.toList();
      }
    }

    if (genresWithFlags.every((element) => element[1] == false)) {
      filteredMovies = movies;
    }
  }

  void toggleGenreSelection(int index) {
    setState(() {
      movies = [];
      filteredMovies = [];

      genresWithFlags[index][1] = !(genresWithFlags[index][1] as bool);
    });
  }

  List<Movie> filterMoviesByGenre(String selectedGenre) {
    return movies
        .where((movie) => movie.genres.contains(selectedGenre))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // return
                return Column(
                  children: [
                    Container(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: genresWithFlags.length,
                            itemBuilder: (context, index) {
                              return Genre(
                                genre: genresWithFlags[index][0].toString(),
                                isSelected: genresWithFlags[index][1] as bool,
                                onTap: () {
                                  toggleGenreSelection(index);
                                },
                              );
                            })),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: filteredMovies.length,
                          padding: EdgeInsets.all(20),
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movies: filteredMovies,
                              index: index,
                            );
                          }),
                    ),
                  ],
                );
                // return Text(movies.length.toString());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
