import 'package:blocdioapp/model/genre.dart';
import 'package:blocdioapp/widget/genre_movies.dart';
import 'package:flutter/material.dart';
import 'package:blocdioapp/theme/default.dart' as Theme;

class GenresList extends StatefulWidget {
  final List<Genre> genres;

  const GenresList({Key key, this.genres}) : super(key: key);
  @override
  _GenresListState createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  TabController _tabController;
  _GenresListState(this.genres);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: genres.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Theme.Colors.primaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Theme.Colors.primaryColor,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Theme.Colors.netflixColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                unselectedLabelColor: Theme.Colors.titleColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres.map(
                  (Genre genre) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        genre.name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map((Genre genre) {
              return GenreMovies(genreId: genre.id);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
