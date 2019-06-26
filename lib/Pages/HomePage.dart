import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:news/Pages/HeadLinesPage.dart';
import 'SourcesPage.dart';
import 'HeadLinesPage.dart';
import 'SearchPage.dart';

class Home extends StatelessWidget {
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('user')
            .document(user.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return checkRole(snapshot.data, context);
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }

  Widget checkRole(DocumentSnapshot snapshot, BuildContext context) {
    if (snapshot.data == null) {
      return Center(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    if (snapshot.data['role'] == 'admin') {
      return adminPage(snapshot, context);
    } else {
      return userPage(snapshot, context);
    }
  }

  Widget adminPage(DocumentSnapshot snapshot, BuildContext context) {
    return SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Text(
              'News',
              style:
              TextStyle(fontWeight: FontWeight.bold, fontFamily: 'GoogleSans'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              child: Column(),
            )
          ],
        ));
  }

  Widget userPage(DocumentSnapshot snapshot, BuildContext context) {
    Headlines headlines = Headlines(snapshot, user, key, context);
    SourcesPage sources = SourcesPage(snapshot, user, key, context);
    SearchPage search = SearchPage(snapshot, user, key, context);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.account_balance,color: Colors.black,),
                child: Text(
                  "News",
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
              ),
              Tab(
                icon: Icon(Icons.search,color: Colors.black,),
                child: Text(
                  "Search",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
              Tab(
                icon: Icon(Icons.scatter_plot,color: Colors.black,),
                child: Text(
                  "Sources",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              headlines.Head(),
              search.search(),
              sources.Source()

            ],
          ),
        ),
    );

  }
}