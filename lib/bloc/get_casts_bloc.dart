import 'package:blocdioapp/model/cast_data.dart';
import 'package:blocdioapp/store/movie_store.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class CastBloc {
  final MovieStore _store = MovieStore();
  final BehaviorSubject<CastData> _subject = BehaviorSubject<CastData>();

  getCasts(int id) async {
    CastData data = await _store.getCasts(id);
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

  BehaviorSubject<CastData> get subject => _subject;
}

final castBloc = CastBloc();
