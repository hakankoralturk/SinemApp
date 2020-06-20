import 'package:blocdioapp/widget/genres.dart';
import 'package:blocdioapp/widget/now_playing.dart';
import 'package:blocdioapp/widget/persons.dart';
import 'package:blocdioapp/widget/top_movies.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:blocdioapp/theme/default.dart' as Theme;

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.Colors.primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.Colors.primaryColor,
        elevation: 8,
        title: Image.asset(
          'assets/images/logo.png',
          height: size.width / 11,
        ),
        leading: IconButton(
          padding: EdgeInsets.only(left: 30.0),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            EvaIcons.menu2Outline,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 30.0),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(
              EvaIcons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          NowPlaying(),
          Genres(),
          PersonList(),
          TopMovies(),
        ],
      ),
    );
  }
}
