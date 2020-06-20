import 'package:blocdioapp/model/movie.dart';

class MovieData {
  final List<Movie> movies;
  final String error;

  MovieData(this.movies, this.error);

  MovieData.fromJson(Map<String, dynamic> json)
      : movies =
            (json["results"] as List).map((i) => Movie.fromJson(i)).toList(),
        error = "";

  MovieData.withError(String errorValue)
      : movies = List(),
        error = errorValue;
}
