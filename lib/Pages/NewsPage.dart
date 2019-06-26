import 'dart:io';
import 'dart:ui';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Photo {
  final String url;
  Photo(this.url);
}

class Page extends StatelessWidget {
  final FirebaseUser user;
  final Key key;
  final String des;
  final String url;
  final String title;
  final String content;
  final String urlI;
  final String author;
  final String topic;

  Page(this.key, this.user, this.url, this.urlI, this.des, this.title,
      this.content, this.author, this.topic);

  @override
  Widget build(BuildContext context) {
    final directory = getApplicationDocumentsDirectory();

    Future<String> s() async {
      var data = await http.get(
          "https://api.unsplash.com/search/collections?client_id=6e65ae0850c40631f6cde646fbd32999ae2fb2bca0bdd194520bbec0b95f525e&query=" +
              topic +
              "&page=1&per_page=10");
      Map m = jsonDecode(data.body);
      Random rnd;
      int min = 1;
      int max = 10;
      rnd = new Random();
      int i = min + rnd.nextInt(max - min);
      print(m["results"][i]["preview_photos"][1]["urls"]["regular"]);
      return (m["results"][i]["preview_photos"][1]["urls"]["regular"]);
    }

    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
              onTap: () {},
              child: ListView(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                        child: Stack(
                      children: <Widget>[
                        Image.network(
                          urlI,
                          filterQuality: FilterQuality.none,
                          scale: 0.5,
                          fit: BoxFit.fill,
                        )
                      ],
                    )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                  SizedBox(height: 40.0),
                  Text(title,
                      style: TextStyle(
                        fontSize: 50.0,
                        fontFamily: 'GoogleSans',
                      )),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(author,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontStyle: FontStyle.italic)),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(content,
                      style:
                          TextStyle(fontSize: 30.0, fontFamily: 'GoogleSans')),
                  SizedBox(
                    height: 25.0,
                  ),
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                        child: Stack(
                      children: <Widget>[
                        FutureBuilder(
                          future: s(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Container(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            } else {
                              return FadeInImage.assetNetwork(
                                  fadeInDuration: Duration(seconds: 1),
                                  fadeInCurve: Curves.easeIn,
                                  placeholder: "Text",
                                  image: snapshot.data);
                            }
                          },
                        )
                      ],
                    )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(des,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'GoogleSans',
                      )),
                  SizedBox(
                    height: 25.0,
                  ),
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                        child: Stack(
                      children: <Widget>[
                        FutureBuilder(
                          future: s(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Container(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            } else {
                              return FadeInImage.assetNetwork(
                                  fadeInDuration: Duration(seconds: 1),
                                  fadeInCurve: Curves.easeIn,
                                  placeholder: "Text",
                                  image: snapshot.data);
                            }
                          },
                        )
                      ],
                    )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                ],
              ))),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        curve: Curves.elasticIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.share),
              backgroundColor: Colors.red,
              label: 'Share',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => Share.share(url)),
          SpeedDialChild(
            child: Icon(Icons.open_in_browser),
            backgroundColor: Colors.blue,
            label: 'Open in Browser',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              _launchURL(url);
            },
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
