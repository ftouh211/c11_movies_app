import 'package:flutter/material.dart';
import 'package:c11_movie_app/utils/api_maneger.dart';
import 'package:c11_movie_app/models/movies_genre.dart';

class MoviesByGenre extends StatefulWidget {
  final int genreId;

  const MoviesByGenre({super.key, required this.genreId});

  @override
  _MoviesByGenreState createState() => _MoviesByGenreState();
}

class _MoviesByGenreState extends State<MoviesByGenre> {
  late Future<MoviesGenre> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = ApiManager.getGenre(widget.genreId); // Pass genreId here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Movies by Genre',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xff1c1c1e),
      ),
      body: FutureBuilder<MoviesGenre>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.results!.isEmpty) {
            return const Center(child: Text('No movies available'));
          }

          final movies = snapshot.data!.results;

          return ListView.separated(
            itemCount: movies?.length ?? 0,
            itemBuilder: (context, index) {
              final movie = movies?[index];
              return Container(
                // color: Colors.blue,
                // height: 250,
                child: ListTile(
                  leading: movie?.posterPath != null
                      ? Image.network(
                    'https://image.tmdb.org/t/p/w500${movie?.posterPath}',
                    width: 100,
                    height: 400,
                    fit: BoxFit.cover,
                  )
                      : const Placeholder(fallbackHeight: 150, fallbackWidth: 100),
                  title: Text(
                    movie?.title ?? 'No Title',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    movie?.releaseDate ?? 'No Release Date',
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Handle movie tap, e.g., navigate to movie details page
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10,),
          );
        },
      ),
    );
  }
}
