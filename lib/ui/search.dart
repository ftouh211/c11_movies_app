import 'package:c11_movie_app/models/search_response.dart';
import 'package:c11_movie_app/utils/api_maneger.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  static const String routeName = "search";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  List<Results> movies = [];
  bool isLoading = false;
  bool isError = false;

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        movies = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      SearchResponse searchResponse = await ApiManager.getSearch(query);
      setState(() {
        movies = searchResponse.results!;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121312),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: (query) {
                _searchMovies(query);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Body
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : movies.isEmpty
                  ? _buildEmptyState()
                  : _buildMovieList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieList() {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        var movie = movies[index];
        var imageUrl = movie.posterPath != null
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            : 'https://via.placeholder.com/150';
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10), // Space between image and text


              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      movie.releaseDate?.substring(0, 4) ?? 'Unknown Date',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      movie.overview ?? 'No description available',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white60,
                      ),
                      maxLines: 3,  // Limit to 3 lines of text
                      overflow: TextOverflow.ellipsis,  // Handle overflow
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(color: Colors.white30),
    );
  }

  // Build the empty state UI
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.movie, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text('No movies found', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
