
import 'package:c11_movie_app/ui/watchlist.dart';
import 'package:c11_movie_app/utils/api_maneger.dart';
import 'package:c11_movie_app/models/similer_response.dart';
import 'package:flutter/material.dart';
import 'package:c11_movie_app/models/detiels_model.dart';

class MovieDetails extends StatelessWidget {
  int movieId;

  MovieDetails({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),
      appBar: AppBar(
        backgroundColor: Color(0xff1D1E1D),
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: FutureBuilder<MovesDetiels>(
          future: ApiManager.getMovieDetails(movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }
            if (snapshot.hasError) {
              return const Text("Error");
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Text("No Title");
            }

            var movie = snapshot.data!;
            return Text(
              movie.title ?? "No Title",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FutureBuilder<MovesDetiels>(
              future: ApiManager.getMovieDetails(movieId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text("Something went wrong: ",style: TextStyle(color: Colors.white),));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text("No details available",style: TextStyle(color: Colors.white),));
                }

                var movie = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      movie.title ?? "No Title",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' ${movie.releaseDate ?? "Unknown"}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                                      width: 130,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Space between image and text

                                  // Movie Details (Title, Date, Overview)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title ?? 'Unknown Title',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          movie.releaseDate?.substring(0, 4) ??
                                              'Unknown Date',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          movie.overview ??
                                              'No description available',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white60,
                                          ),
                                          maxLines:
                                              3, // Limit to 3 lines of text
                                          overflow: TextOverflow
                                              .ellipsis, // Handle overflow
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Color(0xffFFBB3B),
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${movie.voteAverage?.toStringAsFixed(1) ?? "N/A"} (${movie.voteCount ?? 0} votes)',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 7,
                              left: 0,
                              child: Container(
                                width: 40,
                                height: 40,
                                // color: Colors.yellow,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.bookmark,
                                    color: Color(0xff514F4F),
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, Watchlist.routeName);
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 7,
                              left: 0,
                              child: Container(
                                // color: Colors.greenAccent,
                                width: 40,
                                height: 40,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.add,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, Watchlist.routeName);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<SimilarResponse>(
              future: ApiManager.getSimilarMovie(movieId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text("Something went wrong: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text("No movies available"));
                }

                var topRated = snapshot.data?.results ?? [];
                return Container(
                  color: Color(0xff282A28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "More Like This",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: topRated.length,
                          itemBuilder: (context, index) {
                            var movie = topRated[index];
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Stack(children: [
                                Container(
                                  // width: 127,
                                  height: 135,
                                  child: movie.posterPath != null
                                      ? Image.network(
                                          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(Icons.image_not_supported),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    // color: Colors.yellow,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.bookmark,
                                        color: Color(0xff514F4F),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context, Watchlist.routeName);
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 1,
                                  child: Container(
                                    // color: Colors.greenAccent,
                                    width: 22,
                                    height: 22,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.add,
                                        size: 11,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context, Watchlist.routeName);
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 135,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Color(0xffFFBB3B),
                                        size: 12,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        movie.voteAverage.toString(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 150,
                                  child: Text(
                                    movie.title ?? "No Title",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Positioned(
                                  top: 165,
                                  child: Text(
                                    movie.releaseDate?.substring(0, 10) ??
                                        "No Title",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffB5B4B4),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]),
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
      ),
    );
  }
}
