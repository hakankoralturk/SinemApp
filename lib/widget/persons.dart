import 'package:blocdioapp/bloc/get_persons_bloc.dart';
import 'package:blocdioapp/model/person.dart';
import 'package:blocdioapp/model/person_data.dart';
import 'package:flutter/material.dart';
import 'package:blocdioapp/theme/default.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonList extends StatefulWidget {
  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  @override
  void initState() {
    super.initState();

    personsBloc..getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            "Bu Hafta Trend Olan Kişiler".toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.Colors.titleColor,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(height: 5),
        StreamBuilder<PersonData>(
          stream: personsBloc.subject.stream,
          builder: (context, AsyncSnapshot<PersonData> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _errorWidget(snapshot.data.error);
              }
              return _personsWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _errorWidget(snapshot.data.error);
            } else {
              return _loadingWidget();
            }
          },
        ),
      ],
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Text"),
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error"),
        ],
      ),
    );
  }

  Widget _personsWidget(PersonData data) {
    List<Person> persons = data.persons;
    return Container(
      height: 130,
      padding: EdgeInsets.only(left: 10),
      child: ListView.builder(
        itemCount: persons.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10, right: 8),
            child: Column(
              children: [
                persons[index].profileImg == null
                    ? Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.Colors.titleColor,
                        ),
                        child:
                            Icon(FontAwesomeIcons.userAlt, color: Colors.white),
                      )
                    : Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w200" +
                                    persons[index].profileImg),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  persons[index].name,
                  maxLines: 2,
                  style: TextStyle(
                    height: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Trending for ${persons[index].known}",
                  style: TextStyle(
                      color: Theme.Colors.titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 7),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
