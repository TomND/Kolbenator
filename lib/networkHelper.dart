
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:first_flutter/peopleDeets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  static Future<List<String>> fetchData(String locale) async {
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

//  static Widget fetchCloudData(){
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection("people").snapshots(),
//      builder: (context,snapshot){
//        if (!snapshot.hasData) return LinearProgressIndicator();
//
//        return snapshot.data.documents;
//      },
//    )
//  }

}