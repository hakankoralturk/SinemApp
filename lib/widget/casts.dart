import 'package:blocdioapp/bloc/get_casts_bloc.dart';
import 'package:blocdioapp/model/cast.dart';
import 'package:blocdioapp/model/cast_data.dart';
import 'package:blocdioapp/model/movie_data.dart';
import 'package:flutter/material.dart';
import 'package:blocdioapp/theme/default.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Casts extends StatefulWidget {
  final int id;

  const Casts({Key key, @required this.id}) : super(key: key);
  @override
  _CastsState createState() => _CastsState(id);
}

class _CastsState extends State<Casts> {
  final int id;

  _CastsState(this.id);

  @override
  void initState() {
    super.initState();
    castBloc..getCasts(id);
  }

  @override
  void dispose() {
    super.dispose();
    castBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            "Oyuncular".toUpperCase(),
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
        StreamBuilder<CastData>(
          stream: castBloc.subject.stream,
          builder: (context, AsyncSnapshot<CastData> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _errorWidget(snapshot.data.error);
              }
              return _castsWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _errorWidget(snapshot.error);
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

  Widget _castsWidget(CastData data) {
    List<Cast> casts = data.casts;
    return Container(
      height: 150,
      padding: EdgeInsets.only(left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: casts.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10, right: 8),
            width: 100,
            child: GestureDetector(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  casts[index].img == null
                      ? Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.Colors.titleColor,
                          ),
                          child: Icon(FontAwesomeIcons.userAlt,
                              color: Colors.white),
                        )
                      : Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w200" +
                                      casts[index].img),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    casts[index].name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    casts[index].character,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.Colors.titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 7,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
