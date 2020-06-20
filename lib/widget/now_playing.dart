import 'package:blocdioapp/bloc/get_now_playing_bloc.dart';
import 'package:blocdioapp/model/movie.dart';
import 'package:blocdioapp/model/movie_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:blocdioapp/theme/default.dart' as Theme;

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc..getPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieData>(
        stream: nowPlayingMoviesBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieData> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _errorWidget(snapshot.data.error);
            }
            return _nowPlayingWidget(snapshot.data);
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
          Text("Text"),
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

  Widget _nowPlayingWidget(MovieData data) {
    Size size = MediaQuery.of(context).size;

    List<Movie> movies = data.movies;
    if (movies.length == 00) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("No Movies")],
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(size.width / 2, 40),
          bottomRight: Radius.elliptical(size.width / 2, 40),
        ),
        child: Container(
          height: 220,
          child: PageIndicatorContainer(
            align: IndicatorAlign.bottom,
            indicatorSpace: 8,
            padding: EdgeInsets.all(5),
            indicatorColor: Theme.Colors.titleColor.withOpacity(0.5),
            indicatorSelectorColor: Theme.Colors.netflixColor.withOpacity(0.8),
            shape: IndicatorShape.circle(size: 8),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.take(5).length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/original/" +
                                  movies[index].backPoster),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.Colors.primaryColor.withOpacity(1.0),
                            Theme.Colors.primaryColor.withOpacity(0.0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [
                            0.0,
                            0.9,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Icon(FontAwesomeIcons.playCircle,
                          color: Theme.Colors.netflixColor.withOpacity(0.8),
                          size: 48),
                    ),
                    Positioned(
                      bottom: 40,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movies[index].title,
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            length: movies.take(5).length,
          ),
        ),
      );
    }
  }
}
