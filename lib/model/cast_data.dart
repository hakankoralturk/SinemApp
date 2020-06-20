import 'package:blocdioapp/model/cast.dart';

class CastData {
  final List<Cast> casts;
  final String error;

  CastData(this.casts, this.error);

  CastData.fromJson(Map<String, dynamic> json)
      : casts = (json["cast"] as List).map((i) => Cast.fromJson(i)).toList(),
        error = "";

  CastData.withError(String errorValue)
      : casts = List(),
        error = errorValue;
}
