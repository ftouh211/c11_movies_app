import 'package:c11_movie_app/models/movies.dart';
import 'package:c11_movie_app/ui/movie_details.dart';
import 'package:c11_movie_app/utils/api_maneger.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Watchlist extends StatefulWidget {
  static const String routeName = "Watchlist";

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  List<int> watchlist = [];
  List<Movie> watchlistMovies = [];

  @override
  void initState() {
    super.initState();
    print("Watchlist page initialized"); // Debugging to confirm initState is running
    _loadWatchlist();
  }

  Future<void> _loadWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedWatchlist = prefs.getStringList('watchlist');

    // Debugging to check if watchlist is saved in SharedPreferences
    print("Saved watchlist in SharedPreferences: $savedWatchlist");

    if (savedWatchlist != null) {
      setState(() {
        watchlist = savedWatchlist.map((id) => int.parse(id)).toList();
      });
    } else {
      print("No watchlist found in SharedPreferences.");
    }

    print("Watchlist loaded: $watchlist"); // Debugging print statement

    _loadWatchlistMovies();
  }

  Future<void> _loadWatchlistMovies() async {
    List<Movie> movies = [];
    for (var movieId in watchlist) {
      try {
        var movieDetails = await ApiManager.getMovieDetails(movieId);
        if (movieDetails != null) {
          movies.add(movieDetails as Movie);
        }
      } catch (e) {
        print('Error fetching details for movie ID $movieId: $e');
      }
    }
    setState(() {
      watchlistMovies = movies;
    });
  }

  void _toggleWatchlist(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (watchlist.contains(movieId)) {
        watchlist.remove(movieId);
      } else {
        watchlist.add(movieId);
      }
    });

    // Save updated watchlist to SharedPreferences
    List<String> savedWatchlist = watchlist.map((id) => id.toString()).toList();
    await prefs.setStringList('watchlist', savedWatchlist);

    // Debugging print to confirm save
    print("Updated watchlist saved: $savedWatchlist");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),
      appBar: AppBar(
        title: const Text('Your Watchlist',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
      ),
      body: watchlistMovies.isEmpty
          ? const Center(
        child: Text(
          "Your watchlist is empty",
          style: TextStyle(color: Colors.blue),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: watchlistMovies.length,
        itemBuilder: (context, index) {
          var movie = watchlistMovies[index];
          String posterUrl =
              'https://image.tmdb.org/t/p/w500${movie.posterPath}';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MovieDetails(movieId: movie.id!),
                ),
              );
            },
            child: GridTile(
              child: Image.network(posterUrl, fit: BoxFit.cover),
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(
                  movie.title ?? 'No Title',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
