import 'package:intro_slider/intro_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'TopicPage.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  State<StatefulWidget> createState() {
    return MySplashScreenState(user);
  }
}

class MySplashScreenState extends State<MySplashScreen> {
  FirebaseUser user;
  MySplashScreenState(this.user);
  List<Slide> slides = new List();
  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "News",
        styleTitle: TextStyle(fontFamily: "GoogleSans", fontSize: 60.0),
        description: "This gives feed of your interests",
        styleDescription: TextStyle(fontFamily: "GoogleSans", fontSize: 40.0),
        pathImage: "images/logo.png",
        backgroundColor: Colors.greenAccent,
      ),
    );
    slides.add(
      new Slide(
        title: "Topics",
        styleTitle: TextStyle(fontFamily: "GoogleSans", fontSize: 60.0),
        description: "There is a wide range of topics such as Tech, World etc.",
        styleDescription: TextStyle(fontFamily: "GoogleSans", fontSize: 40.0),
        pathImage: "images/world.png",
        backgroundColor: Colors.tealAccent,
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Topic(user:user)));
  }

  void onSkipPress() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Topic(user:user)));
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    );
  }
}
