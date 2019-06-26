import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'SourcePage.dart';
import 'package:news/Class/SourceClass.dart';

class SourcesPage {

  final DocumentSnapshot snapshot;
  final FirebaseUser user;
  final Key key;
  final BuildContext context;

  SourcesPage(this.snapshot, this.user, this.key, this.context);

  List<Sources> source = [
    Sources("ABC","abc-news", "images/abc.jpg"),
    Sources("Associated Press","associated-press", "images/220px-Associated_Press_logo_2012.svg.png"),
    Sources("Al Jazeera","al-jazeera-english", "images/alJazeera.jpg"),
    Sources("BBC","bbc-news", "images/bbc.png"),
    Sources("Bloomberg","bloomberg", "images/alrBF_dr_400x400.jpg"),
    Sources("Buzzfeed","buzzfeed", "images/buzzfeed.jpg"),
    Sources("CNBC","cnbc", "images/2000px-CNBC_logo.svg.png"),
    Sources("CBS News","cbs-news", "images/unnamed.jpg"),
    Sources("CNN","cnn", "images/CNN.png"),
    Sources("Daily Mail","daily-mail","images/Daily-Mail-Logo.jpg"),
    Sources("Engadget","daily-mail","images/eng-logo-white.png"),
    Sources("Entertainment Weekly","entertainment-weekly","images/entertainment-weekly-logo-1000.png"),
    Sources("ESPN","espn", "images/ESPN.jpg"),
    Sources("Hacker News","hacker-news", "images/hn.png"),
    Sources("IGN","ign", "images/ign.jpg"),
    Sources("Polygon","polygon", "images/polygon.png"),
    Sources("Techradar","techradar", "images/techRadar.jpg"),
    Sources("The Times of India","the-times-of-india", "images/toi.png"),
    Sources("The Verge","the-verge", "images/Verge.png"),
  ];

  Widget Source() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Sources",
                      style: TextStyle(
                          fontSize: 50.0
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    scrollDirection: Axis.vertical,
                    children: List.generate(source.length, (index) {
                      return GestureDetector(
                        onTap: (){
                          SourcePage sourcepage = SourcePage(snapshot, user, key, context, source[index]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  sourcepage.Source()
                              ));
                        },
                        child:  Card(
                          child: Image.asset(source[index].imageSrc,
                          ),
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      );
                    })),
              )
            ],
          ),
        ));
  }
}
