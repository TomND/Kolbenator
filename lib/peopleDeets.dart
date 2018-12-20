import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:first_flutter/Person.dart';
import 'package:first_flutter/verticalSlider.dart';


enum AppBarBehaviour {normal, pinned, floating, snapping}


class PeopleDeets extends StatelessWidget{

  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Person person;

  PeopleDeets({Key key, @required this.person}) : super(key: key);


  AppBarBehaviour _appBarBehaviour = AppBarBehaviour.pinned;

  final double _appBarHeight = 256.0;

  Widget kolbeScores(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,100,0,0),
      child: new Transform(
        alignment: FractionalOffset.center,
        transform: new Matrix4.identity()..rotateZ(90 * 3.1415927/180),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0,30,0,30),
                child: new Row(
                  children: <Widget>[
                    new Transform(
                      alignment: FractionalOffset.center,
                      transform: new Matrix4.identity()..rotateZ(-90 * 3.1415927/180),
                      child: Text(
                        person.implementor.toString(),
                      ),
                    ),
                    VerticalSlider(
                      value: person.implementor.toDouble(),
                      min: 1.0,
                      max: 9.0,
                      activeColor: Colors.yellow,
                      divisions: 9,
                      onChanged: (d) {
                        //Empty as color is greyed out if onChanged is null
                      },
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0,30,0,30),
                child: new Row(
                  children: <Widget>[
                    new Transform(
                      alignment: FractionalOffset.center,
                      transform: new Matrix4.identity()..rotateZ(-90 * 3.1415927/180),
                      child: Text(
                        person.quickStart.toString(),
                      ),
                    ),
                    VerticalSlider(
                      value: person.quickStart.toDouble(),
                      min: 1.0,
                      max: 9.0,
                      activeColor: Colors.lightGreenAccent,
                      divisions: 9,
                      onChanged: (d) {
                        //Empty as color is greyed out if onChanged is null
                      },
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0,30,0,30),
                child: new Row(
                  children: <Widget>[
                    new Transform(
                      alignment: FractionalOffset.center,
                      transform: new Matrix4.identity()..rotateZ(-90 * 3.1415927/180),
                      child: Text(
                        person.followThru.toString(),
                      ),
                    ),
                    VerticalSlider(
                      value: person.followThru.toDouble(),
                      min: 1.0,
                      max: 9.0,
                      activeColor: Colors.blue,
                      divisions: 9,
                      onChanged: (d) {
                        //Empty as color is greyed out if onChanged is null
                      },
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0,30,0,30),
                child: new Row(
                  children: <Widget>[
                    new Transform(
                      alignment: FractionalOffset.center,
                      transform: new Matrix4.identity()..rotateZ(-90 * 3.1415927/180),
                      child: Text(
                        person.factFinder.toString(),
                      ),
                    ),
                    VerticalSlider(

                      value: person.factFinder.toDouble(),
                      min: 1.0,
                      max: 9.0,
                      activeColor: Colors.red,
                      divisions: 9,
                      onChanged: (d) {
                        //Empty as color is greyed out if onChanged is null
                      },
                    ),
                  ],
                )
            )
          ],
        ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        platform: Theme.of(context).platform,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: _appBarHeight,
              pinned: true ,
              floating: false ,
              snap: _appBarBehaviour == AppBarBehaviour.snapping ,

              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.create),
                  tooltip: 'Edit',
                  onPressed: (){
                    _scaffoldKey.currentState.showSnackBar(const SnackBar(
                        content: Text("Editing Coming soon")));
                  },
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(person.name),
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      person.image,
                      fit: BoxFit.cover,
                      height: _appBarHeight,
                    ),
                    const DecoratedBox(decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, -0.4),
                            colors: <Color>[Color(0x60000000),Color(0x00000000)])
                    )),
                  ],

                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate(<Widget>[
              AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: Column(
                  children: <Widget>[
                    kolbeScores(),
                    Text("SKILLS: Android, Java, Not sleeping, Coffee Addiction, Drinking Tea")
                  ],
                ),
              )
            ]))
          ],
        )
      ),
    );
  }
}