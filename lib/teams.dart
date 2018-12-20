import 'dart:async';
import 'dart:convert';

import 'package:first_flutter/teamDeets.dart';
import 'package:first_flutter/team.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:first_flutter/networkHelper.dart';
import 'package:first_flutter/addTeam.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class Teams extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teams"),
      ),
      body: Center(
        child: TeamsHomePage(),
      ),
      floatingActionButton: new FloatingActionButton(
        elevation: 4.0,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTeam()));
        },
      ),
    );
  }


}

class TeamsHomePage extends StatefulWidget {
  @override
  _TeamsPageState createState() => new _TeamsPageState();
}

class _TeamsPageState extends State<TeamsHomePage> {
  @override
  Widget build(BuildContext context) {
    var streamBuilder = new StreamBuilder(
      stream: Firestore.instance.collection("teams").snapshots(),
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

  String kolbeTrailingText(Team team){
    String trail;
    trail = team.members.length.toString() + " members";
    return trail;
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot){
    final team = Team.fromSnapshot(snapshot);

    return Padding(
      key: ValueKey(team.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: ListTile(
          title: Text(team.name),
          trailing: Column(
            children: <Widget>[
              Text(kolbeTrailingText(team)),
//              Image.network(person.image,
//              fit: BoxFit.scaleDown,) TODO: IMAGES
            ],
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TeamDeets(team: team)));
          },
        ),
      ),
    );
  }

  Widget createListView(BuildContext context, List<DocumentSnapshot> snapshot) {

    return ListView(
        padding: const EdgeInsets.only(top:20.0),
        children: snapshot.map((data) => _buildListItem(context,data)).toList()
    );

  }
}
