import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_panel/search_item.dart';
import 'package:news/Class/NewsClass.dart';
import 'package:news/Pages/NewsPage.dart';
import 'ResultPage.dart';
import 'dart:convert';
import 'package:flutter_search_panel/flutter_search_panel.dart';
import 'package:http/http.dart' as http;

class SearchPage {
  final DocumentSnapshot snapshot;
  final FirebaseUser user;
  final Key key;
  final BuildContext context;

  SearchPage(this.snapshot, this.user, this.key, this.context);

  String _search;
  final myController = TextEditingController();

  Widget search() {
    List<SearchItem<int>> data = [
      SearchItem(0, 'This'),
      SearchItem(1, 'is'),
      SearchItem(2, 'a'),
      SearchItem(3, 'test'),
      SearchItem(4, '.'),
    ];
    String to = "";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          /*FlutterSearchPanel<int>(
            padding: EdgeInsets.all(10.0),
            selected: 3,
            title: 'Demo Search Page',
            data: data,
            icon: new Icon(Icons.check_circle, color: Colors.white),
            color: Colors.blue,
            textStyle: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0, decorationStyle: TextDecorationStyle.dotted),
          ),*/
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 50.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans'),
              controller: myController,
              onSubmitted: (input) => _search = input,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white12,
              ),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                child: Text(' Search ',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'GoogleSans',
                        fontSize: 15.0)),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                onPressed: () {
                  to = myController.text;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Result(snapshot, user, key, context, to),
                      ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget heading(String s) {
  return Text(s,
      style: TextStyle(
          fontSize: 30.0, color: Colors.black, fontFamily: 'GoogleSans'));
}

Widget para(String s) {
  return Text(s,
      style: TextStyle(
          fontSize: 15.0, color: Colors.black, fontFamily: 'GoogleSans'));
}

Widget author(String s, String n) {
  if (s == null) s = "Author";
  String a = s + "\n" + n;
  return Text(a,
      style: TextStyle(
          fontSize: 20.0,
          color: Colors.black,
          fontFamily: 'GoogleSans',
          fontStyle: FontStyle.italic));
}

bool isNullEmptyOrFalse(Object o) => o == null || false == o || "" == o;
