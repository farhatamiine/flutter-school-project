import 'package:TripPlanner/pages/SecondPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.title, this.description});

  final title;
  final description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(context, title, description),
      ),
    );
  }

  makeListTile(context, title, descritpion) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
            border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24),
            ),
          ),
          child: Icon(Icons.event_note, color: Colors.white),
        ),
        title: Text(
          "Title : " + title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SecondPage(title: title, description: descritpion),
                ),
              );
            },
            child: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0)),
      );
}
