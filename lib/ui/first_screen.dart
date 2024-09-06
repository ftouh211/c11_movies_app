import 'package:c11_movie_app/ui/movie_details.dart';
import 'package:c11_movie_app/utils/api_maneger.dart';
import 'package:c11_movie_app/models/detiels_model.dart';
import 'package:c11_movie_app/models/populer_response.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {

  static const String routeName = "FirstPage";
   FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  static const String routeName = "first";
  int selectedIndex=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121312),
      body: Column(
        children: [
          FutureBuilder(
            future: ApiManager.getMovies(),
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

              var movies = snapshot.data!.results ?? [];

              return CarouselSlider.builder(
                itemCount: movies.length,
                itemBuilder:
                    (BuildContext context, int index, int realIndex) {
                  var movie = movies[index];
                  String posterUrl =
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}'; // Construct the full poster URL

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
                        left: MediaQuery.of(context).size.width / 2 -
                            40, // Center icon horizontally
                        child: Icon(
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
                                // color: Colors.yellow,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.bookmark,color: Color(0xff514F4F),size: 40,),
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
                                height:40,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.add,size: 22,color: Colors.white,),
                                  onPressed: () {
                                    // Navigator.pushNamed(context, MovesDetiels.routeName);
                                  },
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 160, // Center text horizontally
                        child: Text(
                          movie.title ?? "No Title",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 160, // Center text horizontally
                        child: Text(
                          movie.releaseDate?.substring(0, 10) ?? "",
                          style: TextStyle(
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
                  autoPlayInterval: Duration(seconds: 3),
                  viewportFraction:
                  1.0, // Make the carousel take up the whole width
                ),
              );
            },
          ),
          FutureBuilder(
            future: ApiManager.getUpcoming(),
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

              var upcomingMovies = snapshot.data?.results ?? [];
              return Container(
                color: Color(0xff282A28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 5),
                      child: Text(
                        "New Releases ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
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
                            child: Stack(children: [
                              Container(
                                // width: 127,
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
                                    icon: Icon(Icons.bookmark,color: Color(0xff514F4F),),
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
                                  height:22,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.add,size: 11,color: Colors.white,),
                                    onPressed: () {
                                      // Navigator.pushNamed(context, MovesDetiels.routeName);
                                    },
                                  ),
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
          SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: ApiManager.getTop(),
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
                      padding: const EdgeInsets.only(left: 10,top: 10),
                      child: Text(
                        "Top Rated ",
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
                                    icon: Icon(Icons.bookmark,color: Color(0xff514F4F),),
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
                                  height:22,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.add,size: 11,color: Colors.white,),
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
                                  movie.releaseDate?.substring(0, 10) ?? "No Title",
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
    );
  }
}


