import 'package:blocdioapp/model/person.dart';

class PersonData {
  final List<Person> persons;
  final String error;

  PersonData(this.persons, this.error);

  PersonData.fromJson(Map<String, dynamic> json)
      : persons =
            (json["results"] as List).map((i) => Person.fromJson(i)).toList(),
        error = "";

  PersonData.withError(String errorValue)
      : persons = List(),
        error = errorValue;
}
