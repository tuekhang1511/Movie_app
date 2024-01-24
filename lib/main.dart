// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_info/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => HomePage(),
      },
      // home: HomePage(),
      theme: ThemeData(
          // brightness: Brightness.dark,
          // primarySwatch: Colors.orange,
          ),
    );
  }
}
