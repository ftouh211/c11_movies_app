// // import 'package:c11_movie_app/api_maneger.dart';
// // import 'package:flutter/material.dart';
// //
// // class HomeScreen extends StatelessWidget {
// //   static const String routeName = "home";
// //   const HomeScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Movies App"),
// //       ),
// //       body: FutureBuilder(future: ApiManeger.getMovies(),
// //           builder: (context, snapshot) {
// //             if(snapshot.connectionState==ConnectionState.waiting){
// //               return Center(child: CircularProgressIndicator());
// //             }
// //             if(snapshot.hasError){
// //               return Text("Somthing went wrong");
// //             }
// //
// //             var movies = snapshot.data?.results??[];
// //
// //             return ListView.builder(itemBuilder: (context, index) {
// //               return Text(movies[index].title??"");
// //             },
// //             itemCount: movies.length,);
// //           },),
// //     );
// //   }
// // }
//
// import 'package:c11_movie_app/api_maneger.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   static const String routeName = "home";
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Movies App"),
//       ),
//       body: FutureBuilder(
//         future: ApiManager.getMovies(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text("Something went wrong"));
//           }
//
//
//           var movies = snapshot.data!.results ?? [];
//
//           return ListView.builder(
//             itemBuilder: (context, index) {
//               var movie = movies[index];
//               String posterUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';
//
//               return ListTile(
//                 leading: Image.network(
//                   posterUrl,
//                   fit: BoxFit.cover,
//                   width: 50,
//                   height: 75,
//                 ),
//                 title: Text(movie.title ?? ""),
//               );
//             },
//             itemCount: movies.length,
//           );
//         },
//       ),
//     );
//   }
// }
