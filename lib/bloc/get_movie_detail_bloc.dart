import 'package:blocdioapp/model/movie_detail_data.dart';
import 'package:blocdioapp/store/movie_store.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class MovieDetailBloc {
  final MovieStore _store = MovieStore();
  final BehaviorSubject<MovieDetailData> _subject =
      BehaviorSubject<MovieDetailData>();

  getMovieDetail(int id) async {
    MovieDetailData data = await _store.getMovieDetail(id);
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

  BehaviorSubject<MovieDetailData> get subject => _subject;
}

final movieDetailBloc = MovieDetailBloc();
