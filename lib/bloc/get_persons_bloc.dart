import 'package:blocdioapp/model/person_data.dart';
import 'package:blocdioapp/store/movie_store.dart';
import 'package:rxdart/subjects.dart';

class PersonsListBloc {
  final MovieStore _store = MovieStore();
  final BehaviorSubject<PersonData> _subject = BehaviorSubject<PersonData>();

  getPersons() async {
    PersonData data = await _store.getPersons();
    _subject.sink.add(data);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonData> get subject => _subject;
}

final personsBloc = PersonsListBloc();
