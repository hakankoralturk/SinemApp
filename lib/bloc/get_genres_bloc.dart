import 'package:blocdioapp/model/genre_data.dart';
import 'package:blocdioapp/store/movie_store.dart';
import 'package:rxdart/subjects.dart';

class GenresListBloc {
  final MovieStore _store = MovieStore();
  final BehaviorSubject<GenreData> _subject = BehaviorSubject<GenreData>();

  getGenres() async {
    GenreData data = await _store.getGenres();
    _subject.sink.add(data);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreData> get subject => _subject;
}

final genresBloc = GenresListBloc();
