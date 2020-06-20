import 'package:blocdioapp/model/video_data.dart';
import 'package:blocdioapp/store/movie_store.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class MovieVideosBloc {
  final MovieStore _store = MovieStore();
  final BehaviorSubject<VideoData> _subject = BehaviorSubject<VideoData>();

  getMovieVideos(int id) async {
    VideoData data = await _store.getMovieVideos(id);
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

  BehaviorSubject<VideoData> get subject => _subject;
}

final movieVideosBloc = MovieVideosBloc();
