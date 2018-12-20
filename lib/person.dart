import 'dart:async';
import 'dart:convert';

import 'package:first_flutter/peopleDeets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:first_flutter/networkHelper.dart';
import 'package:first_flutter/addPerson.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Person{
  final String name;
  final String image;
  final int factFinder;
  final int followThru;
  final int quickStart;
  final int implementor;
  final DocumentReference reference;

  Person.fromMap(Map<String,dynamic> map, {this.reference})
    : assert(map["name"] != null),
        assert(map["factfinder"] != null),
        assert(map["followthru"] != null),
        assert(map["quickstart"] != null),
        assert(map["implementor"] != null),
        assert(map["image"] != null),
        name = map["name"],
        factFinder = map["factfinder"],
        followThru = map["followthru"],
        quickStart = map["quickstart"],
        implementor = map["implementor"],
        image = map["image"];

  Person.fromSnapshot(DocumentSnapshot snapshot)
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