
import 'package:c11_movie_app/ui/movies_by_genre.dart';
import 'package:flutter/material.dart';
import 'package:c11_movie_app/utils/api_maneger.dart';
import 'package:c11_movie_app/models/catigory_model.dart';

class Browse extends StatefulWidget {
  static const String routeName = "browse";
  const Browse({super.key});

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  late Future<CatogiryModel> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = ApiManager.getCatiogry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Browse Category",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<CatogiryModel>(
                future: _categoriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.genres!.isEmpty) {
                    return const Center(child: Text('No categories available'));
                  }

                  final categories = snapshot.data!.genres;

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: categories?.length,
                    itemBuilder: (context, index) {
                      final category = categories?[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoviesByGenre(genreId: category?.id ?? 0),                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/0e34a5e080e8c915030603ddcdb4eeba.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Center(
                                child: Text(
                                  category?.name ?? "",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    backgroundColor: Colors.black54, // Optional: background color for better readability
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

