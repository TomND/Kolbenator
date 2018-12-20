import 'dart:async';
import 'dart:convert';

import 'package:first_flutter/peopleDeets.dart';
import 'package:first_flutter/Person.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:first_flutter/networkHelper.dart';
import 'package:first_flutter/verticalSlider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddPerson extends StatelessWidget {
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
                hintText: 'What do people call you?',
                labelText: 'Name *',
              ),
              controller: personName,
              validator: _validateName,
            ),

            Padding(
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
                                ilabel,
                              ),
                          ),
                          VerticalSlider(
                            value: implementorValue.toDouble(),
                            min: 1.0,
                            max: 9.0,
                            activeColor: Colors.yellow,
                            divisions: 9,
                            onChanged: (double newVal){
                              setState(() {
                                implementorValue = newVal.round();
                                ilabel = implementorValue.toString();
                              });
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
                                qslabel,
                              ),
                            ),
                            VerticalSlider(
                              value: quickStartValue.toDouble(),
                              min: 1.0,
                              max: 9.0,
                              activeColor: Colors.lightGreenAccent,
                              divisions: 9,
                              onChanged: (double newVal){
                                setState(() {
                                  quickStartValue = newVal.round();
                                  qslabel = quickStartValue.toString();
                                });
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
                                ftlabel,
                              ),
                            ),
                            VerticalSlider(
                              value: followThruValue.toDouble(),
                              min: 1.0,
                              max: 9.0,
                              activeColor: Colors.blue,
                              divisions: 9,
                              onChanged: (double newVal){
                                setState(() {
                                  followThruValue = newVal.round();
                                  ftlabel = followThruValue.toString();
                                });
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
                                fflabel,
                              ),
                            ),
                            VerticalSlider(

                              value: factFinderValue.toDouble(),
                              min: 1.0,
                              max: 9.0,
                              activeColor: Colors.red,
                              divisions: 9,
                              onChanged: (double newVal){
                                setState(() {
                                  factFinderValue = newVal.round();
                                  fflabel = factFinderValue.toString();
                                });
                              },
                            ),
                          ],
                        )
                    )
                  ],
                ),

                ),
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
    Firestore.instance.collection('people').document()
        .setData({
      'name': personName.text,
      'factfinder': factFinderValue,
      'followthru': followThruValue,
      'quickstart': quickStartValue,
      'implementor': implementorValue,
      'image': "https://i.kym-cdn.com/entries/icons/original/000/027/475/Screen_Shot_2018-10-25_at_11.02.15_AM.png"
    });
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




