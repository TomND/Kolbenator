import 'dart:async';
import 'dart:convert';

import 'package:first_flutter/peopleDeets.dart';
import 'package:first_flutter/Person.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:first_flutter/networkHelper.dart';
import 'package:first_flutter/addPerson.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class People extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("People"),
      ),
      body: Center(
        child: PeopleHomePage(),
      ),
      floatingActionButton: new FloatingActionButton(
        elevation: 4.0,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPerson()));
        },
      ),
    );
  }


}

class PeopleHomePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => new _PeoplePageState();
}

class _PeoplePageState extends State<PeopleHomePage> {
  @override
  Widget build(BuildContext context) {
    var streamBuilder = new StreamBuilder(
    stream: Firestore.instance.collection("people").snapshots(),
    builder: (context,snapshot){
      if (!snapshot.hasData) return LinearProgressIndicator();

      return createListView(context,snapshot.data.documents);
      },
    );


//    static Widget fetchCloudData(){
//      return StreamBuilder<QuerySnapshot>(
//        stream: Firestore.instance.collection("people").snapshots(),
//        builder: (context,snapshot){
//          if (!snapshot.hasData) return LinearProgressIndicator();
//
//          return snapshot.data.documents;
//        },
//      )
//    }


//    var futureBuilder = new FutureBuilder(
//      future: NetworkHelper.fetchData("en"),
//      builder: (BuildContext context, AsyncSnapshot snapshot) {
//        switch (snapshot.connectionState) {
//          case ConnectionState.none:
//          case ConnectionState.waiting:
//            return new Text('loading...');
//          default:
//            if (snapshot.hasError)
//              return new Text('Error: ${snapshot.error}');
//            else
//              return createListView(context, snapshot);
//        }
//      },
//    );

    return streamBuilder;
  }

  String kolbeTrailingText(Person person){
    String trail;
    trail = person.factFinder.toString() + " "
    + person.followThru.toString() + " "
        + person.quickStart.toString() + " "
        + person.implementor.toString() + " ";
    return trail;
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot){
    final person = Person.fromSnapshot(snapshot);

    return Padding(
      key: ValueKey(person.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: ListTile(
          title: Text(person.name),
          trailing: Text(kolbeTrailingText(person)),
        ),
      ),
    );
  }

  Widget createListView(BuildContext context, List<DocumentSnapshot> snapshot) {
    DocumentSnapshot test = snapshot[0];

    return ListView(
      padding: const EdgeInsets.only(top:20.0),
      children: snapshot.map((data) => _buildListItem(context,data)).toList()
    );



//    return new ListView.builder(
//      itemCount: snapshot.length,
//      itemBuilder: (BuildContext context, int index) {
//        return new Column(
//          children: <Widget>[
//            GestureDetector(
//              child: new ListTile(
//                title: new Text(snapshot[index]),
//              ),
//              onTap: () {
//                print('row $index was tapped with text ' + values[index]);
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => PeopleDeets(name: values[index])
//                    )
//                );
//              },
//            ),
//            new Divider(
//              height: 2.0,
//            ),
//          ],
//        );
//      },
//    );
  }
}
