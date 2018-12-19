import 'dart:async';
import 'dart:convert';

import 'package:first_flutter/peopleDeets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    var futureBuilder = new FutureBuilder(
      future: fetchPeople("en"),
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

  Future<List<String>> fetchPeople(String locale) async {
    final response = await http.get(
        'https://trending-search.flippback.com/api/v1/suggestions?postal_code=m8x1a1&locale=' +
            locale +
            '&account_guid=b1eff4c2-bb8c-4cbd-88db-025f4b780d7f');

    if (response.statusCode == 200) {
      print(locale);

      // If the call to the server was successful, parse the JSON
      var suggestionsFromJson = json.decode(response.body)['suggestions'];
      return new List<String>.from(suggestionsFromJson);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
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
