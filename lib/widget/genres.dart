import 'package:blocdioapp/bloc/get_genres_bloc.dart';
import 'package:blocdioapp/model/genre.dart';
import 'package:blocdioapp/model/genre_data.dart';
import 'package:blocdioapp/widget/genres_list.dart';
import 'package:flutter/material.dart';

class Genres extends StatefulWidget {
  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  void initState() {
    super.initState();
    genresBloc..getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreData>(
        stream: genresBloc.subject.stream,
        builder: (context, AsyncSnapshot<GenreData> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _errorWidget(snapshot.data.error);
            }
            return _genreWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _errorWidget(snapshot.data.error);
          } else {
            return _loadingWidget();
          }
        });
  }

  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error"),
        ],
      ),
    );
  }

  Widget _genreWidget(GenreData data) {
    List<Genre> genres = data.genres;
    if (genres.length == 0) {
      return Container(
        child: Text("Tür yok"),
      );
    } else
      return GenresList(genres: genres);
  }
}
