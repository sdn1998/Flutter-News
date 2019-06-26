import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news/Pages/HomePage.dart';
import 'package:news/Class/TopicClass.dart';

class Topic extends StatefulWidget {
  const Topic({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  State<StatefulWidget> createState() {
    return TopicState(user);
  }
}


class TopicState extends State<Topic> {
  TopicState(this.user);
  FirebaseUser user;
  List<TopicClass> topics = [
    TopicClass('Tech', 'images/smartphone.png', false),
    TopicClass('Cricket', 'images/cricket.png', false),
    TopicClass('Soccer', 'images/football.png', false),
    TopicClass('Weather', 'images/sun1.png', false),
    TopicClass('World', 'images/worldwide.png', false),
    TopicClass('Business', 'images/coins.png', false),
    TopicClass('India', 'images/india.png', false),
    TopicClass('USA', 'images/usa.png', false),
    TopicClass('UK', 'images/uk.png', false),
    TopicClass('China', 'images/china.jpg', false),
    TopicClass('Lifestyle', 'images/lifestyle.jpg', false),
    TopicClass('Education', 'images/education.jpg', false),
    TopicClass('Health', 'images/healtth.png', false),
    TopicClass('Politics', 'images/Politics.png', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // here the desired height
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          flexibleSpace: Center(
              child: new Text(
            "Topic",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 60.0, color: Colors.black),
          )),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "  Choose the topics...",
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: topics.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  value: topics[index].isCheck,
                  onChanged: (bool newValue) {
                    setState(() {
                      topics[index].isCheck = newValue;
                    });
                  },
                  title: Text(
                    topics[index].name,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  secondary: CircleAvatar(
                    backgroundImage: AssetImage(topics[index].avatarImage),
                  ),
                );
              },
            ),
          ),
         ButtonBar(
           children: <Widget>[
             RaisedButton(
               child: Text(' Next ',
                   style: TextStyle(
                       color: Colors.white, fontFamily: 'GoogleSans',fontSize: 15.0)),
               shape: new RoundedRectangleBorder(
                 borderRadius: new BorderRadius.circular(20.0),
               ),
               onPressed:(){
                 List<String> topic=[];
                 for(int i=0;i<topics.length;i++)
                 {if(topics[i].isCheck)
                   {
                     topic.add(topics[i].name.toLowerCase());
                     print(topics[i].name.toLowerCase());
                   }
                   topicList(topic);
                   }
               } ,
             ),
           ],
         )
        ],
      ),
    );
  }

  void topicList(List<String> topic) async {
    try {
      Firestore.instance
          .collection('user')
          .document(user.uid)
          .setData({'topic ':topic});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home(user: user)));
    } catch (e) {
      print(e.message);
    }
  }
  }


