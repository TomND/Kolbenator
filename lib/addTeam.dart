import 'dart:async';
import 'dart:convert';

import 'package:first_flutter/peopleDeets.dart';
import 'package:first_flutter/person.dart';
import 'package:first_flutter/people.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:first_flutter/networkHelper.dart';
import 'package:first_flutter/verticalSlider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddTeam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add person"),
      ),
      body: Center(
        child: DataForm(),
      ),
    );
  }
}

class DataForm extends StatefulWidget{

  @override
  State createState() => new _DataFormState();

}

class _DataFormState extends State<DataForm> {

  List<Person> members;
  Person person;

  bool _formWasEdited = false;
  final personName = TextEditingController();
  var factFinderValue = 1;
  String fflabel = "1";

  var followThruValue = 1;
  String ftlabel = "1";

  var quickStartValue = 1;
  String qslabel = "1";

  var implementorValue = 1;
  String ilabel = "1";





  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Form(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24.0),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.person),
                hintText: 'Team Name?',
                labelText: 'Name *',
              ),
              controller: personName,
              validator: _validateName,
            ),

            RaisedButton(
              child: Text("Create"),
              onPressed: () {
                Navigator.pop(context);
                createPerson();
              },
            )

          ],
        ),
      ),

      ),
    );
  }


  void createPerson(){
//
//    Firestore.instance.collection("people")
//    .where("name", isEqualTo: "Dennis")
//    .snapshots()
//    .
//    List<Person> people;
//    Firestore.instance.collection("people")
//        .where("name", isEqualTo: "Dennis")
//        .snapshots().listen((data) =>
//        data.documents.forEach((p) => people.add(Person.fromSnapshot(p)))
//
//    ).onDone(() {
//                    Firestore.instance.collection('teams').document()
//              .setData({
//            'name': personName.text,
//            'members': people,
//                    });
//    }
//    );
    Firestore.instance.collection('teams').document()
        .setData({
      'name': personName.text,
      'members': People.allPeople.map((person) => {
        'name': person.name
      }).toList(),
    });
//    var streamBuilder = new StreamBuilder(
//      stream: Firestore.instance.collection("people")
//          .where("name", isEqualTo: "Dennis")
//          .snapshots(),
//      builder: (context,snapshot){
//        if (snapshot.hasData){
//          List<Person> people;
//          List<DocumentSnapshot> docs =snapshot.data.documents;
//          for(DocumentSnapshot snap in docs){
//            Person p  = Person.fromSnapshot(snap);
//            people.add(p);
//          }
////          docs.map((data) => {
////            int c = 0;
//////            Person p  = Person.fromSnapshot(data);
////        });
//              Firestore.instance.collection('teams').document()
//              .setData({
//            'name': personName.text,
//            'members': people,
//          });
//        }
//      },
//    );
//    streamBuilder.
//    return streamBuilder;

  }

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

}




