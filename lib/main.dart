import 'package:flutter/material.dart';
import 'package:fruit_puzzles/home_page.dart';
import 'package:fruit_puzzles/splash_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Fruit Puzzles",
      debugShowCheckedModeBanner: false,
      initialRoute: "splash_page",
      routes: {
        "splash_page": (context) => const SplashPage(),
        "home_page": (context) => const MyHomePage(),
      },
    ),
  );
}
