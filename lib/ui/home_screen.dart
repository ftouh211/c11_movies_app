import 'package:c11_movie_app/ui/first_screen.dart';
import 'package:c11_movie_app/ui/search.dart';
import 'package:c11_movie_app/ui/watchlist.dart';
import 'package:c11_movie_app/utils/api_maneger.dart';
import 'package:c11_movie_app/ui/browse.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff121312),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            // showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xffFFBB3B),
            unselectedItemColor: Colors.white,
            backgroundColor:Color(0xff1A1A1A),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.windowMaximize), label: "Browse"),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.solidBookmark), label: "Watchlist"),

            ]),
        body: tabs[selectedIndex],
      ),
    );
  }
}
List<Widget> tabs = [
  FirstScreen(),
  Search(),
  Browse(),
  Watchlist(),
];

