import 'package:blocdioapp/bloc/get_movie_videos_bloc.dart';
import 'package:blocdioapp/model/movie.dart';
import 'package:blocdioapp/model/video.dart';
import 'package:blocdioapp/model/video_data.dart';
import 'package:blocdioapp/screen/video_player_screen.dart';
import 'package:blocdioapp/widget/casts.dart';
import 'package:blocdioapp/widget/movie_info.dart';
import 'package:blocdioapp/widget/similar_movies.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:blocdioapp/theme/default.dart' as Theme;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({Key key, @required this.movie}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState(movie);
}

class _MovieDetailState extends State<MovieDetailScreen> {
  final Movie movie;

  _MovieDetailState(this.movie);

  @override
  void initState() {
    super.initState();
    movieVideosBloc..getMovieVideos(movie.id);
  }

  @override
  void dispose() {
    super.dispose();
    movieVideosBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.Colors.primaryColor,
      body: Builder(
        builder: (context) {
          return SliverFab(
            floatingPosition: FloatingPosition(right: 20),
            floatingWidget: StreamBuilder<VideoData>(
              stream: movieVideosBloc.subject.stream,
              builder: (context, AsyncSnapshot<VideoData> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length > 0) {
                    return _errorWidget(snapshot.data.error);
                  }
                  return _videoWidget(snapshot.data);
                } else if (snapshot.hasError) {
                  return _errorWidget(snapshot.error);
                } else {
                  return _loadingWidget();
                }
              },
            ),
            expandedHeight: 200,
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.Colors.primaryColor,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    movie.title.length > 38
                        ? movie.title.substring(0, 35) + "..."
                        : movie.title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Stack(
                    children: [
                      movie.backPoster == null
                          ? Container(
                              child: SizedBox(),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/original/" +
                                          movie.backPoster),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ),
                            ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(0.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              movie.rating.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            RatingBar(
                              itemSize: 8,
                              initialRating: movie.rating / 2,
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 20),
                        child: Text(
                          "Genel Bakış".toUpperCase(),
                          style: TextStyle(
                            color: Theme.Colors.titleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          movie.overview,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MovieInfo(
                        id: movie.id,
                      ),
                      Casts(
                        id: movie.id,
                      ),
                      SimilarMovies(
                        id: movie.id,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _loadingWidget() {
    return SizedBox();
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

  Widget _videoWidget(VideoData data) {
    List<Video> videos = data.videos;
    return FloatingActionButton(
      backgroundColor: Theme.Colors.netflixColor,
      child: Icon(Icons.play_arrow),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              controller: YoutubePlayerController(
                initialVideoId: videos[0].key,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
