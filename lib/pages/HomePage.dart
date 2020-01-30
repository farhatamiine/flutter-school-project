import 'package:TripPlanner/utils/CustomCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  TextEditingController taskTitleInputController;
  TextEditingController taskDescripInputController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Use Api"),
        leading: Icon(FontAwesomeIcons.vial),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Task').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new SpinKitPumpingHeart(
                      color: Colors.white38,
                      duration: Duration(milliseconds: 20),
                    );
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new CustomCard(
                          title: document['title'],
                          description: document['description'],
                        );
                      }).toList(),
                    );
                }
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        tooltip: 'Add Task to the List',
        onPressed: _showDialog,
      ),
    );
  }

  @override
  initState() {
    taskTitleInputController = new TextEditingController();
    taskDescripInputController = new TextEditingController();
    super.initState();
  }

  _showDialog() async {
    Alert(
        context: context,
        title: "Make a Task",
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: taskTitleInputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(FontAwesomeIcons.tasks),
                  labelText: 'Task Title',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: taskDescripInputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(FontAwesomeIcons.stickyNote),
                  labelText: 'Task Description',
                ),
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
              child: Text('Add', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (taskDescripInputController.text.isNotEmpty &&
                    taskTitleInputController.text.isNotEmpty) {
                  Firestore.instance
                      .collection('Task')
                      .add({
                        "title": taskTitleInputController.text,
                        "description": taskDescripInputController.text
                      })
                      .then((result) => {
                            Navigator.pop(context),
                            taskTitleInputController.clear(),
                            taskDescripInputController.clear(),
                          })
                      .catchError((err) => print(err));
                }
              })
        ]).show();
  }
}
