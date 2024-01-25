// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Genre extends StatelessWidget {
  final String genre;
  final bool isSelected;
  final VoidCallback onTap;

  Genre({
    required this.genre,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(genre,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.orange : Colors.black,
              )),
        )
    );
  }
}

class GenreList extends StatelessWidget {
  final List genresWithFlags;
  final Function toggleGenreSelection;

  GenreList({
    required this.genresWithFlags,
    required this.toggleGenreSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genresWithFlags.length,
        itemBuilder: (context, index) {
          return Center(
            child: Genre(
              genre: genresWithFlags[index][0].toString(),
              isSelected: genresWithFlags[index][1] as bool,
              onTap: () {
                toggleGenreSelection(index);
              },
            ),
          );
        },
      ),
    );
  }
}
