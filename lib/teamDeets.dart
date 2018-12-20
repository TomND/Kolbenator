import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:first_flutter/person.dart';
import 'package:first_flutter/team.dart';

import 'package:first_flutter/verticalSlider.dart';


enum AppBarBehaviour {normal, pinned, floating, snapping}


class TeamDeets extends StatelessWidget{

  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Person person;
  Team team;


  TeamDeets({Key key, @required this.team}) : super(key: key);


  AppBarBehaviour _appBarBehaviour = AppBarBehaviour.pinned;

  final double _appBarHeight = 256.0;


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        platform: Theme.of(context).platform,
      ),
      child: createListView(context),
    );
  }

  String kolbeTrailingText(){
    String trail;
    trail = "3" + " "
        + "6" + " "
        + "9" + " "
        + "1" + " ";
    return trail;
  }

  Widget _buildListItem(BuildContext context,  dynamic member){
    return Padding(
      key: ValueKey("tearm Name"),
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: ListTile(
          title: Text("Team Name"),
          trailing: Column(
            children: <Widget>[
              Text(kolbeTrailingText()),
//              Image.network(person.image,
//              fit: BoxFit.scaleDown,) TODO: IMAGES
            ],
          ),
        ),
      ),
    );
  }

  Widget createListView(BuildContext context) {

    return ListView(
        padding: const EdgeInsets.only(top:20.0),
        children: team.members.map((tMember) => _buildListItem(context,tMember)).toList()
    );

  }

}