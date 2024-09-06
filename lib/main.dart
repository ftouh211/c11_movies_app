import 'package:c11_movie_app/ui/browse.dart';
import 'package:c11_movie_app/models/detiels_model.dart';
import 'package:c11_movie_app/ui/home_screen.dart';
import 'package:c11_movie_app/ui/search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
        Search.routeName : (context) => Search(),
        Browse.routeName : (context) => Browse(),
      },

    );
  }
}