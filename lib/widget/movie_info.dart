import 'package:blocdioapp/bloc/get_movie_detail_bloc.dart';
import 'package:blocdioapp/model/movie_detail.dart';
import 'package:blocdioapp/model/movie_detail_data.dart';
import 'package:flutter/material.dart';
import 'package:blocdioapp/theme/default.dart' as Theme;

class MovieInfo extends StatefulWidget {
  final int id;

  const MovieInfo({Key key, this.id}) : super(key: key);

  @override
  _MovieInfoState createState() => _MovieInfoState(id);
}

class _MovieInfoState extends State<MovieInfo> {
  final int id;

  _MovieInfoState(this.id);

  @override
  void initState() {
    super.initState();
    movieDetailBloc..getMovieDetail(id);
  }

  @override
  void dispose() {
    super.dispose();
    movieDetailBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailData>(
      stream: movieDetailBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieDetailData> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _errorWidget(snapshot.data.error);
          }
          return _infoWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _errorWidget(snapshot.error);
        } else {
          return _loadingWidget();
        }
      },
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

  Widget _infoWidget(MovieDetailData data) {
    MovieDetail detail = data.movieDetail;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bütçe".toUpperCase(),
                    style: TextStyle(
                        color: Theme.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    detail.budget.toString() + " \$",
                    style: TextStyle(
                      color: Theme.Colors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Süre".toUpperCase(),
                    style: TextStyle(
                        color: Theme.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    detail.runtime.toString() + " \dk",
                    style: TextStyle(
                      color: Theme.Colors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Yayın Tarihi".toUpperCase(),
                    style: TextStyle(
                        color: Theme.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    detail.releaseDate.toString(),
                    style: TextStyle(
                      color: Theme.Colors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Türler".toUpperCase(),
                style: TextStyle(
                  color: Theme.Colors.titleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 28,
                padding: EdgeInsets.only(top: 5),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: detail.genres.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child: Text(
                          detail.genres[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
