import 'package:blocdioapp/model/video.dart';

class VideoData {
  final List<Video> videos;
  final String error;

  VideoData(this.videos, this.error);

  VideoData.fromJson(Map<String, dynamic> json)
      : videos =
            (json["results"] as List).map((e) => Video.fromJson(e)).toList(),
        error = "";

  VideoData.withError(String errorValue)
      : videos = List(),
        error = errorValue;
}
