import 'package:blocdioapp/model/genre.dart';

class GenreData {
  final List<Genre> genres;
  final String error;

  GenreData(this.genres, this.error);

  GenreData.fromJson(Map<String, dynamic> json)
      : genres =
            (json["genres"] as List).map((i) => Genre.fromJson(i)).toList(),
        error = "";

  GenreData.withError(String errorValue)
      : genres = List(),
        error = errorValue;
}
