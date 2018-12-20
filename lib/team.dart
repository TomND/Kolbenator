import 'dart:async';
import 'dart:convert';

import 'package:first_flutter/people.dart';

import 'package:first_flutter/peopleDeets.dart';
import 'package:first_flutter/person.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:first_flutter/networkHelper.dart';
import 'package:first_flutter/addPerson.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Team{
  final String name;
  final DocumentReference reference;
  final List<dynamic> members;

  Team.fromMap(Map<String,dynamic> map, {this.reference})
      : assert(map["name"] != null),
        assert(map["members"] != null),
        name = map["name"],
        members = map["members"];


  Team.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data,reference: snapshot.reference);

//  Person.fromValues(String name, String image, int factFinder, int followThru, int quickStart, int implementor)
//  : this.name = name,
//  this.image = image,
//  this.factFinder = factFinder,
//  this.followThru = followThru,
//  this.quickStart = quickStart,
//  this.implementor = implementor;

  @override
  String toString() {
    return "record<$name>";
  }


}