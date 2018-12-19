import 'dart:async';
import 'dart:convert';

import 'package:first_flutter/peopleDeets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:first_flutter/networkHelper.dart';

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
    var futureBuilder = new FutureBuilder(
      future: NetworkHelper.fetchData("en"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return futureBuilder;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            GestureDetector(
              child: new ListTile(
                title: new Text(values[index]),
              ),
              onTap: () {
                print('row $index was tapped with text ' + values[index]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PeopleDeets(name: values[index])
                    )
                );
              },
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }
}
