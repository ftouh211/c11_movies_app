
import 'dart:convert';
import 'package:c11_movie_app/models/catigory_model.dart';
import 'package:c11_movie_app/models/movies_genre.dart';
import 'package:c11_movie_app/models/search_response.dart';
import 'package:c11_movie_app/utils/constants.dart';
import 'package:c11_movie_app/models/detiels_model.dart';
import 'package:c11_movie_app/models/similer_response.dart';
import 'package:c11_movie_app/models/populer_response.dart';
import 'package:c11_movie_app/models/top_response.dart';
import 'package:c11_movie_app/models/upcoming_resposes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  static Future<PopularResponse> getMovies() async {
    Uri url = Uri.https(
        Constants.baseUrl,
        "/3/movie/popular",
        {
          "language": "en-US",
          "page": "1",
          "api_key": Constants.apiKey // Make sure the API key is correct
        }
    );

    try {
      http.Response response = await http.get(url);
      print("Status Code: ${response.statusCode}"); // Debug: print status code
      print("Response Body: ${response.body}"); // Debug: print the response body

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        PopularResponse popularResponse = PopularResponse.fromJson(json);
        return popularResponse;
      } else {
        throw Exception('Failed to load movies. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }


  //https://api.themoviedb.org/3/genre/movie/list
  static Future<CatogiryModel> getCatiogry() async {
    Uri url = Uri.https(
        Constants.baseUrl,
        "/3/genre/movie/list",
        {
          "language": "en-US",
          "page": "1",
          "api_key": Constants.apiKey // Make sure the API key is correct
        }
    );

    try {
      http.Response response = await http.get(url);
      print("Status Code: ${response.statusCode}"); // Debug: print status code
      print("Response Body: ${response.body}"); // Debug: print the response body

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        CatogiryModel catogiryModel = CatogiryModel.fromJson(json);
        return catogiryModel;
      } else {
        throw Exception('Failed to load movies. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  //https://api.themoviedb.org/3/discover/movie
  static Future<MoviesGenre> getGenre(int genreId) async {
    Uri url = Uri.https(
        Constants.baseUrl,
        "/3/discover/movie",
        {
          "language": "en-US",
          "page": "1",
          "api_key": Constants.apiKey // Make sure the API key is correct
        }
    );

    try {
      http.Response response = await http.get(url);
      print("Status Code: ${response.statusCode}"); // Debug: print status code
      print("Response Body: ${response.body}"); // Debug: print the response body

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        MoviesGenre moviesGenre = MoviesGenre.fromJson(json);
        return moviesGenre;
      } else {
        throw Exception('Failed to load movies. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }




  static Future<SearchResponse> getSearch(String query) async {
    Uri url = Uri.https(
        Constants.baseUrl,
        "/3/search/movie",
        {
          "language": "en-US",
          "page": "1",
          "api_key": Constants.apiKey,
          "query": query // Pass the search query
        }
    );

    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return SearchResponse.fromJson(json); // Parse the response
      } else {
        throw Exception('Failed to load movies. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  //https://api.themoviedb.org/3/movie/{movie_id}
  static Future<MovesDetiels> getMovieDetails(int id) async {

    Uri url = Uri.https(
        Constants.baseUrl,
        "/3/movie/$id",
        {
          "language": "en-US",
          "api_key": Constants.apiKey,
        }
    );

    try {
      http.Response response = await http.get(url);
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        MovesDetiels movieDetails = MovesDetiels.fromJson(json);
        return movieDetails;
      } else {
        throw Exception('Failed to load movie details. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  //https://api.themoviedb.org/3/movie/{movie_id}/similar
  static Future<SimilarResponse> getSimilarMovie(int id) async {
    Uri url = Uri.https(
        Constants.baseUrl,
        "/3/movie/$id/similar", // Corrected endpoint
        {
          "language": "en-US",
          "api_key": Constants.apiKey,
        }
    );

    try {
      http.Response response = await http.get(url);
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        SimilarResponse similarResponse = SimilarResponse.fromJson(json);
        return similarResponse;
      } else {
        throw Exception('Failed to load similar movies. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }




  //https://api.themoviedb.org/3/movie/upcoming
  static Future<UpcomingResposes> getUpcoming() async {
    Uri url = Uri.https(
      Constants.baseUrl ,
      "/3/movie/upcoming",
      {
        "language": "en-US",
        "page": "1",
        "api_key": Constants.apiKey
      }
    );

    try {
      http.Response response = await http.get(url);
      print("Status Code: ${response.statusCode}"); // Debug: print status code
      print("Response Body: ${response.body}"); // Debug: print the response body

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        UpcomingResposes upcomingResposes = UpcomingResposes.fromJson(json);
        return upcomingResposes;
      } else {
        throw Exception('Failed to load movies. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }


  //https://api.themoviedb.org/3/movie/top_rated
  static Future<TopResponses> getTop() async {



    Uri url = Uri.https(
        Constants.baseUrl ,
        "/3/movie/top_rated",
        {
          "language": "en-US",
          "page": "1",
          "api_key": Constants.apiKey
        }
    );

    try {
      http.Response response = await http.get(url);
      print("Status Code: ${response.statusCode}"); // Debug: print status code
      print("Response Body: ${response.body}"); // Debug: print the response body

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        TopResponses topResponses = TopResponses.fromJson(json);
        return topResponses;
      } else {
        throw Exception('Failed to load movies. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}


