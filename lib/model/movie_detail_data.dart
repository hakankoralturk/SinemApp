import 'package:blocdioapp/model/movie_detail.dart';

class MovieDetailData {
  final MovieDetail movieDetail;
  final String error;

  MovieDetailData(this.movieDetail, this.error);

  MovieDetailData.fromJson(Map<String, dynamic> json)
      : movieDetail = MovieDetail.fromJson(json),
        error = "";

  MovieDetailData.withError(String errorValue)
      : movieDetail = MovieDetail(null, null, null, null, "", null),
        error = errorValue;
}
