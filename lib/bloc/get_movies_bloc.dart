import 'package:blocdioapp/model/movie_data.dart';
import 'package:blocdioapp/store/movie_store.dart';
import 'package:rxdart/subjects.dart';

class MoviesListBloc {
  final MovieStore _store = MovieStore();
  final BehaviorSubject<MovieData> _subject = BehaviorSubject<MovieData>();

  getMovies() async {
    MovieData data = await _store.getMovies();
    _subject.sink.add(data);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieData> get subject => _subject;
}

final moviesBloc = MoviesListBloc();
