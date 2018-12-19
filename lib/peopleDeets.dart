import 'package:flutter/material.dart';

class PeopleDeets extends StatelessWidget{
  String name;

  PeopleDeets({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("People Details"),
      ),
      body: Center(
        child: Text(name + "'s deets\nComing soon to a phone near you"),
      ),
    );
  }
}