import 'package:blocdioapp/model/movie_data.dart';
import 'package:blocdioapp/store/movie_store.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class MoviesListByGenreBloc {
  final MovieStore _store = MovieStore();
  final BehaviorSubject<MovieData> _subject = BehaviorSubject<MovieData>();

  getMoviesByGenre(int id) async {
    MovieData data = await _store.getMoviesByGenre(id);
    _subject.sink.add(data);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieData> get subject => _subject;
}

final moviesByGenreBloc = MoviesListByGenreBloc();
