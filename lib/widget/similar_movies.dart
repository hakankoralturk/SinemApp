import 'package:blocdioapp/bloc/get_movie_similar_bloc.dart';
import 'package:blocdioapp/bloc/get_movies_bloc.dart';
import 'package:blocdioapp/model/movie.dart';
import 'package:blocdioapp/model/movie_data.dart';
import 'package:blocdioapp/screen/detail_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:blocdioapp/theme/default.dart' as Theme;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SimilarMovies extends StatefulWidget {
  final int id;

  const SimilarMovies({Key key, @required this.id}) : super(key: key);

  @override
  _SimilarMoviesState createState() => _SimilarMoviesState(id);
}

class _SimilarMoviesState extends State<SimilarMovies> {
  final int id;

  _SimilarMoviesState(this.id);

  @override
  void initState() {
    super.initState();
    similarMoviesBloc..getSimilarMovies(id);
  }

  @override
  void dispose() {
    super.dispose();
    similarMoviesBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            "Benzer Filmler".toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.Colors.titleColor,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        StreamBuilder<MovieData>(
          stream: similarMoviesBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieData> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _errorWidget(snapshot.data.error);
              }
              return _moviesWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _errorWidget(snapshot.data.error);
            } else {
              return _loadingWidget();
            }
          },
        ),
      ],
    );
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

  Widget _moviesWidget(MovieData data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        child: Text("Film yok"),
      );
    } else
      return Container(
        height: 270,
        padding: EdgeInsets.only(left: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailScreen(movie: movies[index]),
                    ),
                  );
                },
                child: Column(
                  children: [
                    movies[index].poster == null
                        ? Container(
                            width: 120,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Theme.Colors.secondaryColor,
                              borderRadius: BorderRadius.circular(2),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              children: [
                                Icon(EvaIcons.filmOutline,
                                    color: Colors.white, size: 50),
                              ],
                            ),
                          )
                        : Container(
                            width: 120,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200/" +
                                        movies[index].poster),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 100,
                      height: 30,
                      alignment: Alignment.center,
                      child: Text(
                        movies[index].title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.4),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          movies[index].rating.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RatingBar(
                          itemSize: 8,
                          initialRating: movies[index].rating / 2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2),
                          itemBuilder: (context, _) => Icon(
                            EvaIcons.star,
                            color: Theme.Colors.secondaryColor,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
