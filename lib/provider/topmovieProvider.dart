import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieku/models/movie.dart';

class TopMovieProvider extends ChangeNotifier {
  getTopmovie() async {
    var result = await http.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=5098a9e3ca4920eb139726beda7dbdf6&language=en-US&page=1');

    if (result.statusCode == 200) {
      List data = jsonDecode(result.body)['results'];
      List<Movie> movies = data.map((e) => Movie.fromJson(e)).toList();
      return movies;
    } else {
      return [];
    }
  }
}
