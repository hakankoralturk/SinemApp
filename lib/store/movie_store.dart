import 'package:blocdioapp/model/cast_data.dart';
import 'package:blocdioapp/model/genre_data.dart';
import 'package:blocdioapp/model/movie_data.dart';
import 'package:blocdioapp/model/movie_detail_data.dart';
import 'package:blocdioapp/model/person_data.dart';
import 'package:blocdioapp/model/video_data.dart';
import 'package:dio/dio.dart';

class MovieStore {
  final String apiKey = "YOUR API KEY";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = '$mainUrl/genre/movie/list';
  var getPersonsUrl = '$mainUrl/trending/person/week';
  var movieUrl = '$mainUrl/movie';

  Future<MovieData> getPopularMovies() async {
    var params = {"api_key": apiKey, "language": "tr-TR", "page": 1};

    try {
      Response res = await _dio.get(getPopularUrl, queryParameters: params);
      return MovieData.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieData.withError("$error");
    }
  }

  Future<MovieData> getMovies() async {
    var params = {"api_key": apiKey, "language": "tr-TR", "page": 1};

    try {
      Response res = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieData.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieData.withError("$error");
    }
  }

  Future<MovieData> getPlayingMovies() async {
    var params = {"api_key": apiKey, "language": "tr-TR", "page": 1};

    try {
      Response res = await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieData.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieData.withError("$error");
    }
  }

  Future<GenreData> getGenres() async {
    var params = {"api_key": apiKey, "language": "tr-TR", "page": 1};

    try {
      Response res = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreData.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return GenreData.withError("$error");
    }
  }

  Future<PersonData> getPersons() async {
    var params = {"api_key": apiKey};

    try {
      Response res = await _dio.get(getPersonsUrl, queryParameters: params);
      return PersonData.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return PersonData.withError("$error");
    }
  }

  Future<MovieData> getMoviesByGenre(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "tr-TR",
      "page": 1,
      "with_genres": id
    };

    try {
      Response res = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieData.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieData.withError("$error");
    }
  }

  Future<MovieDetailData> getMovieDetail(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "tr-TR",
    };

    try {
      Response res = await _dio.get(movieUrl + "/$id", queryParameters: params);
      return MovieDetailData.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieDetailData.withError("$error");
    }
  }

  Future<CastData> getCasts(int id) async {
    var params = {"api_key": apiKey, "language": "tr-TR"};

    try {
      Response res = await _dio.get(movieUrl + "/$id" + "/credits",
          queryParameters: params);
      return CastData.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return CastData.withError("$error");
    }
  }

  Future<MovieData> getSimilarMovies(int id) async {
    var params = {"api_key": apiKey, "language": "tr-TR"};

    try {
      Response res = await _dio.get(movieUrl + "/$id" + "/similar",
          queryParameters: params);
      return MovieData.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieData.withError("$error");
    }
  }

  Future<VideoData> getMovieVideos(int id) async {
    var params = {"api_key": apiKey, "language": "tr-TR"};

    try {
      Response res = await _dio.get(movieUrl + "/$id" + "/videos",
          queryParameters: params);
      return VideoData.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return VideoData.withError("$error");
    }
  }
}
