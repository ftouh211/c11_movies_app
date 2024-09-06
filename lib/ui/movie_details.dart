// import 'package:c11_movie_app/api_maneger.dart';
// import 'package:flutter/material.dart';
// import 'package:c11_movie_app/detiels_model.dart'; // Ensure the path is correct
//
// class MovieDetails extends StatelessWidget {
//   final int movieId;
//
//   const MovieDetails({super.key, required this.movieId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         backgroundColor: Color(0xff121312),
//         appBar: AppBar(
//           title: Text('Movie Details'),
//         ),
//         body: FutureBuilder<MovesDetiels>(
//           future: ApiManager.getMovieDetails(movieId),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }
//             if (snapshot.hasError) {
//               return Center(child: Text("Something went wrong: ${snapshot.error}"));
//             }
//             if (!snapshot.hasData || snapshot.data == null) {
//               return Center(child: Text("No details available"));
//             }
//
//             var movie = snapshot.data!;
//
//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.network(
//                     'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: 250,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       movie.title ?? "No Title",
//                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       movie.tagline ?? "",
//                       style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Release Date: ${movie.releaseDate ?? "Unknown"}',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Rating: ${movie.voteAverage?.toStringAsFixed(1) ?? "N/A"} (${movie.voteCount ?? 0} votes)',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       movie.overview ?? "No Overview Available",
//                       style: TextStyle(fontSize: 16),
//                       maxLines: 2,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Genres: ${movie.genres?.map((g) => g.name).join(', ') ?? "Unknown"}',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   // You can add more details here based on your model
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

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
                      child: Text("Something went wrong: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text("No details available"));
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
                    SizedBox(height: 10,),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 129,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500${movie.backdropPath}'),
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
                                // color: Colors.yellow,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.bookmark,
                                    color: Color(0xff514F4F),
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    // Navigator.pushNamed(context, MovieDetails.routeName);
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
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
                                    // Navigator.pushNamed(context, MovesDetiels.routeName);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 140),
                              child: Container(
                                // color: Colors.blue,
                                child: Column(
                                  children: [
                                    Text(
                                      movie.overview ?? "No Overview Available",
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Genres: ${movie.genres?.map((g) => g.name).join(', ') ?? "Unknown"}',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
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
                                        // Navigator.pushNamed(context, MovesDetiels.routeName);
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
                                        // Navigator.pushNamed(context, MovesDetiels.routeName);
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
