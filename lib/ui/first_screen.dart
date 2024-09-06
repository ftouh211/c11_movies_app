
import 'package:c11_movie_app/ui/movie_details.dart';
import 'package:c11_movie_app/ui/watchlist.dart';
import 'package:c11_movie_app/utils/api_maneger.dart';
import 'package:c11_movie_app/models/populer_response.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  static const String routeName = "FirstPage";
  FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<int> watchlist = [];

  @override
  void initState() {
    super.initState();
    _loadWatchlist();
  }

  Future<void> _loadWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      watchlist = (prefs.getStringList('watchlist') ?? [])
          .map((id) => int.parse(id))
          .toList();
    });
  }

  Future<void> _saveWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('watchlist', watchlist.map((id) => id.toString()).toList());
  }

  Future<void> _toggleWatchlist(int movieId) async {

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (watchlist.contains(movieId)) {
        watchlist.remove(movieId);
      } else {
        watchlist.add(movieId);
      }
      _saveWatchlist();
    });
    List<String> savedWatchlist = watchlist.map((id) => id.toString()).toList();
    await prefs.setStringList('watchlist', savedWatchlist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),
      body: Column(
        children: [
          FutureBuilder(
            future: ApiManager.getMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Something went wrong: ${snapshot.error}"));
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text("No movies available"));
              }

              var movies = snapshot.data!.results ?? [];

              return CarouselSlider.builder(
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  var movie = movies[index];
                  String posterUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';

                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (movie.id != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetails(movieId: movie.id!),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 270,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(posterUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 85,
                        left: MediaQuery.of(context).size.width / 2 - 40,
                        child: const Icon(
                          Icons.play_circle_fill,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 15,
                        child: Stack(
                          children: [
                            Container(
                              width: 129,
                              height: 199,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(posterUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: 40,
                                height: 40,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    watchlist.contains(movie.id)
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: const Color(0xffF7B539),
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    _toggleWatchlist(movie.id!); // Toggle watchlist
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 160,
                        child: Text(
                          movie.title ?? "No Title",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 160,
                        child: Text(
                          movie.releaseDate?.substring(0, 10) ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                options: CarouselOptions(
                  height: 370,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 2.0,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 1.0,
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          FutureBuilder(
            future: ApiManager.getUpcoming(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Something went wrong: ${snapshot.error}"));
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text("No movies available"));
              }

              var upcomingMovies = snapshot.data?.results ?? [];
              return Container(
                color: const Color(0xff282A28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "New Releases ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: upcomingMovies.length,
                        itemBuilder: (context, index) {
                          var movie = upcomingMovies[index];
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Stack(
                              children: [
                                Container(
                                  child: movie.posterPath != null
                                      ? Image.network(
                                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                    fit: BoxFit.cover,
                                  )
                                      : const Icon(Icons.image_not_supported),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        watchlist.contains(movie.id)
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                        color: const Color(0xffF7B539),
                                      ),
                                      onPressed: () {
                                        _toggleWatchlist(movie.id!);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          FutureBuilder(
            future: ApiManager.getTop(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Something went wrong: ${snapshot.error}"));
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text("No movies available"));
              }

              var topRated = snapshot.data?.results ?? [];
              return Container(
                color: const Color(0xff282A28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        "Top Rated ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: topRated.length,
                        itemBuilder: (context, index) {
                          var movie = topRated[index];
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Stack(
                              children: [
                                Container(
                                  child: movie.posterPath != null
                                      ? Image.network(
                                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                    fit: BoxFit.cover,
                                  )
                                      : const Icon(Icons.image_not_supported),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        watchlist.contains(movie.id)
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                        color: const Color(0xffF7B539),
                                      ),
                                      onPressed: () {
                                        _toggleWatchlist(movie.id!);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Watchlist.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
