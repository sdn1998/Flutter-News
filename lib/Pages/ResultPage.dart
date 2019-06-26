import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';
import 'NewsPage.dart';
import 'package:flutter/animation.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:news/Class/NewsClass.dart';

class Result extends StatelessWidget {

  final DocumentSnapshot snapshot;
  final FirebaseUser user;
  final Key key;
  final String word;
  final BuildContext context;

  Result(this.snapshot,this.user,this.key,this.context,this.word);

  Widget page()
  {
    Future<List<News>> _getNews() async {
      List<News> ne = [];
       var d = await http.get("https://newsapi.org/v2/everything?q=" +
             word+
            "&sortBy=publishedAt&language=en&apiKey=3c6be11cce54498e9c70621d43b0f814");
        Map map = json.decode(d.body);
        for (int j = 0; j < map.length; j++) {
          if(isNullEmptyOrFalse(map["articles"][j]["title"]))
          {
            map["articles"][j]["title"] = "title";
          }
          if(isNullEmptyOrFalse(map["articles"][j]["content"]))
          {
            map["articles"][j]["content"] = "content";
          }
          if(isNullEmptyOrFalse(map["articles"][j]["description"]))
          {
            map["articles"][j]["description"] = "description";
          }
          if(isNullEmptyOrFalse(map["articles"][j]["url"]))
          {
            map["articles"][j]["url"] = "url";
          }
          if(isNullEmptyOrFalse(map["articles"][j]["urlToImage"]))
          {
            map["articles"][j]["urlToImage"] = "https://learnenglishorstarve.files.wordpress.com/2017/06/news-tsodotcom.jpg";
          }
          if(isNullEmptyOrFalse(map["articles"][j]["author"]))
          {
            map["articles"][j]["author"] = "Author";
          }
          if(isNullEmptyOrFalse(map["articles"][j]["source"]))
          {
            map["articles"][j]["source"]["name"] = "Source";
          }
          News t = News(
              map["articles"][j]["title"],
              map["articles"][j]["content"],
              map["articles"][j]["description"],
              map["articles"][j]["url"],
              map["articles"][j]["urlToImage"],
              map["articles"][j]["author"],
              map["articles"][j]["source"]["name"],
              word);
          ne.add(t);

      }
      /*for (int j = 0; j < t.length; j++) {
        Map decoded = t[j];
        print(decoded["articles"][1]["source"]["name"]);
        for (int i = 0; i < decoded.length; i++) {
          News t = News(
              decoded["articles"][i]["title"],
              decoded["articles"][i]["content"],
              decoded["articles"][i]["url"],
              decoded["articles"][i]["urlToImage"],
              decoded["articles"][i]["author"],
              decoded["articles"][i]["source"]["name"],
              topics[0][j]);
          ne.add(t);
        }
      }*/
      //ne.add(News("Hi","sdsddfsdf","www.google.com","https://cdn.gsmarena.com/imgroot/news/19/03/ad-fraud-multiple-videos/-727w2/gsmarena_002.jpg","Author","BBC","tech"));
      return ne;
    }

    return Scaffold(
        body: Padding(
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
                        "Results",
                        style: TextStyle(
                            fontSize: 50.0
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: FutureBuilder(
                      future: _getNews(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Page(
                                            key,
                                            user,
                                            snapshot.data[index].url,
                                            snapshot.data[index].urlI,
                                            snapshot.data[index].des,
                                            snapshot.data[index].title,
                                            snapshot.data[index].content,
                                            snapshot.data[index].author,
                                            snapshot.data[index].topic,
                                          ),
                                        ));
                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Container(
                                        child: Stack(
                                          children: <Widget>[
                                            FadeInImage.assetNetwork(
                                                fadeInDuration: Duration(seconds: 2),
                                                fadeInCurve: Curves.easeIn,
                                                placeholder: "Text", image:snapshot.data[index].urlI ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 20.0,
                                                ),
                                                Card(
                                                  margin: EdgeInsets.all(5),
                                                  child: ListTile(
                                                    title: heading(
                                                        snapshot.data[index].title),
                                                    subtitle: author(
                                                        snapshot.data[index].author,
                                                        snapshot.data[index].source),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 5,
                                    margin: EdgeInsets.all(10),
                                  ));
                            },
                          );
                        }
                      },
                    )),
              ],
            ),
          ),
        ));
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

  bool isNullEmptyOrFalse(Object o) =>
      o == null || false == o || "" == o;

  @override
  Widget build(BuildContext context) {
    return page();
  }
}

